# DevWeave Specification: Attachment Extraction & Optical Character Recognition (OCR)

## 1. Overview

Work items and user stories frequently contain essential context embedded in attachments: requirement documents, legacy screen mockups, entity-relationship diagrams, SQL schemas, and log exports.

DevWeave provides a unified, safe attachment extraction and OCR pipeline that parses text and visual evidence without leaking secrets, introducing security vulnerabilities, or fabricating unreadable content.

---

## 2. Attachment Classification Taxonomy

When attachments are discovered on a work item, they are classified into five standard categories:

| Category | Typical File Extensions | Processing Behavior |
|---|---|---|
| **TEXT** | `.txt`, `.md`, `.json`, `.csv`, `.xml`, `.yaml`, `.yml`, `.sql`, `.log`, `.html` | Safe text extraction, UTF-8 normalization, path sanitization. |
| **DOCUMENT** | `.pdf`, `.docx`, `.xlsx`, `.pptx` | Structured document parsing or text extraction where parsers are present; non-blocking fallback if parser unavailable. |
| **IMAGE** | `.png`, `.jpg`, `.jpeg`, `.bmp`, `.tiff`, `.webp`, `.svg` | Dispatched to OCR engine with confidence score and quality assessment. |
| **ARCHIVE** | `.zip`, `.tar.gz`, `.7z` | Inventory file listing; recursive extraction only under explicit policy. |
| **OTHER** | Executables, binaries, unknown extensions | Recorded in attachment metadata; payload not read. |

---

## 3. Image OCR Processing Pipeline

```text
Image Attachment
       ↓
Validate Format & Size (< 25MB)
       ↓
Invoke OCR Engine (Tesseract / System Vision / Model Vision)
       ↓
Extract Visual Text & Structured Layout
       ↓
Evaluate Extraction Quality
       ├── SUCCESS: Confidence >= 80%, clean layout extracted
       ├── PARTIAL: Confidence 40-79%, partial text extracted with warnings
       └── FAILED:  Confidence < 40% or engine error
       ↓
Store Extracted Text in .devweave/modernization/stories/<ID>/evidence/
       ↓
Link Reference in work-item.json & evidence.json
```

---

## 4. Invariance & Guardrail Rules

1. **Non-Blocking Invariance**: An OCR failure or missing OCR binary MUST NOT halt the modernization lifecycle. If OCR fails, record status `FAILED`, note the inability to parse visual content in `evidence.json`, and proceed with text-based context.
2. **Zero Hallucination Invariance**: The AI MUST NEVER extrapolate, hallucinate, or fabricate visual elements that are unreadable or blurred in the image.
3. **Path Traversal Protection**: Attachment filenames must be sanitized against directory traversal attacks (e.g. `../../etc/passwd` or `..\..\Windows\System32`). All downloaded files are stored strictly within the sandboxed `.devweave/modernization/stories/<ID>/evidence/` directory.
4. **Cleanup & Retention**: Temporary binary files are purged after text extraction; extracted plain text is persisted for AI reasoning.
