<#
.SYNOPSIS
    DevWeave Deterministic JSON Schema Conformance Validator
.DESCRIPTION
    Validates all 13 canonical DevWeave JSON schemas against positive (valid)
    and negative (invalid) fixtures without external third-party dependencies.
#>

param(
    [string]$SchemasDir = "D:\DevWeave\conformance\schemas",
    [string]$ValidFixturesDir = "D:\DevWeave\conformance\fixtures\schemas\valid",
    [string]$InvalidFixturesDir = "D:\DevWeave\conformance\fixtures\schemas\invalid"
)

$ErrorActionPreference = "Stop"

function Test-JsonSchemaInstance {
    param(
        [PSCustomObject]$Schema,
        [PSCustomObject]$Data,
        [string]$Path = "root"
    )

    $errors = @()

    if ($null -eq $Data) {
        $errors += "[$Path] Data is null."
        return $errors
    }

    # 1. Type validation
    if ($Schema.type) {
        $expectedType = $Schema.type
        $actualType = $Data.GetType().Name

        if ($expectedType -eq "object" -and ($Data -isnot [PSCustomObject] -and $Data -isnot [System.Collections.IDictionary])) {
            $errors += "[$Path] Expected object, got $actualType"
        }
        elseif ($expectedType -eq "array" -and ($Data -isnot [System.Array] -and $Data -isnot [System.Collections.IList])) {
            $errors += "[$Path] Expected array, got $actualType"
        }
        elseif ($expectedType -eq "string" -and ($Data -isnot [string])) {
            $errors += "[$Path] Expected string, got $actualType"
        }
        elseif ($expectedType -eq "integer" -and ($Data -isnot [int] -and $Data -isnot [long])) {
            $errors += "[$Path] Expected integer, got $actualType"
        }
        elseif ($expectedType -eq "number" -and ($Data -isnot [int] -and $Data -isnot [long] -and $Data -isnot [double] -and $Data -isnot [decimal] -and $Data -isnot [float])) {
            $errors += "[$Path] Expected number, got $actualType"
        }
        elseif ($expectedType -eq "boolean" -and ($Data -isnot [bool])) {
            $errors += "[$Path] Expected boolean, got $actualType"
        }
    }

    # 2. Required fields
    if ($Schema.required -and ($Data -is [PSCustomObject])) {
        foreach ($req in $Schema.required) {
            $propValue = $Data.$req
            if ($null -eq $propValue -or ($propValue -is [string] -and [string]::IsNullOrWhiteSpace($propValue))) {
                $errors += "[$Path] Missing required property: '$req'"
            }
        }
    }

    # 3. Enum validation
    if ($Schema.enum) {
        if ($Schema.enum -notcontains $Data) {
            $errors += "[$Path] Value '$Data' not in allowed enum: [$($Schema.enum -join ', ')]"
        }
    }

    # 4. Pattern validation
    if ($Schema.pattern -and ($Data -is [string])) {
        if ($Data -notmatch $Schema.pattern) {
            $errors += "[$Path] String '$Data' does not match pattern '$($Schema.pattern)'"
        }
    }

    # 5. Numeric range
    if ($Schema.minimum -ne $null) {
        if ($Data -lt $Schema.minimum) {
            $errors += "[$Path] Value $Data is less than minimum $($Schema.minimum)"
        }
    }
    if ($Schema.maximum -ne $null) {
        if ($Data -gt $Schema.maximum) {
            $errors += "[$Path] Value $Data is greater than maximum $($Schema.maximum)"
        }
    }

    # 6. Min/Max items for arrays
    if ($Data -is [System.Array] -or $Data -is [System.Collections.IList]) {
        if ($Schema.minItems -ne $null -and $Data.Count -lt $Schema.minItems) {
            $errors += "[$Path] Array has $($Data.Count) items, minimum is $($Schema.minItems)"
        }
        if ($Schema.items -and $Schema.items -is [PSCustomObject]) {
            for ($i = 0; $i -lt $Data.Count; $i++) {
                $subErrors = Test-JsonSchemaInstance -Schema $Schema.items -Data $Data[$i] -Path "$Path[$i]"
                $errors += $subErrors
            }
        }
    }

    # 7. Properties validation
    if ($Schema.properties -and ($Data -is [PSCustomObject])) {
        foreach ($prop in $Data.PSObject.Properties) {
            $propName = $prop.Name
            $propVal = $prop.Value

            if ($Schema.properties.$propName) {
                $subSchema = $Schema.properties.$propName
                $subErrors = Test-JsonSchemaInstance -Schema $subSchema -Data $propVal -Path "$Path.$propName"
                $errors += $subErrors
            }
            elseif ($Schema.additionalProperties -eq $false) {
                $errors += "[$Path] Additional property not allowed: '$propName'"
            }
        }
    }

    return $errors
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DevWeave V1.0 Deterministic JSON Schema Validator     " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$schemaFiles = Get-ChildItem -Path $SchemasDir -Filter "*.schema.json"
$totalTests = 0
$passedCount = 0
$failedCount = 0
$results = @()

foreach ($schemaFile in $schemaFiles) {
    $baseName = $schemaFile.BaseName.Replace(".schema", "")
    $schemaContent = Get-Content -Raw $schemaFile.FullName | ConvertFrom-Json

    $validFixturePath = Join-Path $ValidFixturesDir "$baseName.valid.json"
    $invalidFixturePath = Join-Path $InvalidFixturesDir "$baseName.invalid.json"

    # Test Valid Fixture
    if (Test-Path $validFixturePath) {
        $totalTests++
        $data = Get-Content -Raw $validFixturePath | ConvertFrom-Json
        $errs = Test-JsonSchemaInstance -Schema $schemaContent -Data $data -Path $baseName

        if ($errs.Count -eq 0) {
            Write-Host "  [PASS] $baseName (valid fixture passed validation)" -ForegroundColor Green
            $passedCount++
            $results += [PSCustomObject]@{ Schema = $baseName; Fixture = "valid"; Result = "PASS"; Details = "Valid" }
        }
        else {
            Write-Host "  [FAIL] $baseName (valid fixture failed unexpectedly): $($errs -join '; ')" -ForegroundColor Red
            $failedCount++
            $results += [PSCustomObject]@{ Schema = $baseName; Fixture = "valid"; Result = "FAIL"; Details = ($errs -join "; ") }
        }
    }

    # Test Invalid Fixture
    if (Test-Path $invalidFixturePath) {
        $totalTests++
        $data = Get-Content -Raw $invalidFixturePath | ConvertFrom-Json
        $errs = Test-JsonSchemaInstance -Schema $schemaContent -Data $data -Path $baseName

        if ($errs.Count -gt 0) {
            Write-Host "  [PASS] $baseName (invalid fixture correctly rejected with $($errs.Count) errors)" -ForegroundColor Green
            $passedCount++
            $results += [PSCustomObject]@{ Schema = $baseName; Fixture = "invalid"; Result = "PASS"; Details = "Correctly rejected: $($errs[0])" }
        }
        else {
            Write-Host "  [FAIL] $baseName (invalid fixture was unexpectedly accepted!)" -ForegroundColor Red
            $failedCount++
            $results += [PSCustomObject]@{ Schema = $baseName; Fixture = "invalid"; Result = "FAIL"; Details = "Invalid artifact accepted" }
        }
    }
}

Write-Host "----------------------------------------------------------"
$summaryColor = if ($failedCount -eq 0) { "Green" } else { "Red" }
Write-Host "Summary: Total=$totalTests, Passed=$passedCount, Failed=$failedCount" -ForegroundColor $summaryColor

if ($failedCount -gt 0) {
    exit 1
} else {
    exit 0
}
