# DevWeave Test Intelligence — V1.0 + V1.1 Implementation Change Specification

## 1. Purpose

This document defines a shared **Test Intelligence** capability for DevWeave.

The capability applies to:

- V1.0 normal development
- V1.1 modernization

The central principle is:

> **Every code change carries its corresponding test impact. DevWeave automatically updates affected existing tests and creates missing tests based on the approved user story and implementation plan.**

Testing is therefore part of implementation, not a separate afterthought.

---

# 2. Core Behavior

The expected flow is:

```text
User Story
    ↓
ANALYZE
    ↓
Identify affected code + behavior + existing tests
    ↓
PLAN
    ↓
Create implementation + test plan
    ↓
IMPLEMENT
    │
    ├── Modify production code
    ├── Update affected existing tests
    └── Create missing tests
    ↓
VERIFY
    ↓
Run affected + regression tests
    ↓
Fix legitimate implementation/test issues
    ↓
Report
```

DevWeave must reason about the relationship between:

```text
User Story
    ↓
Expected Behavior
    ↓
Test Intent
    ↓
Production Implementation
    ↓
Test Implementation
```

It must not simply modify tests until the test suite becomes green.

---

# 3. Scope

## V1.0

For normal development stories:

```text
User Story
    ↓
Test Impact Analysis
    ↓
Test Planning
    ↓
Implementation
    ↓
Test Updates + New Tests
    ↓
Verification
```

## V1.1 Modernization

For modernization:

```text
Legacy Behavior
    ↓
Behavior/Test Discovery
    ↓
Modernization Test Model
    ↓
Target Implementation
    ↓
Existing Test Updates + New Tests
    ↓
Behavior Preservation Verification
```

The same Test Intelligence capability should serve both workflows.

---

# 4. Test Intelligence Architecture

```text
                         DevWeave
                            │
                     Test Intelligence
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ↓                   ↓                   ↓
 Test Discovery       Test Impact         Test Generation
        │                   │                   │
        └───────────────────┼───────────────────┘
                            ↓
                     Test Strategy
                            ↓
                  Test Execution Engine
                            │
       ┌────────────────────┼────────────────────┐
       ↓                    ↓                    ↓
   Unit Tests            API Tests          UI / E2E
                                               │
                              ┌────────────────┼──────────────┐
                              ↓                ↓              ↓
                         Playwright         Cypress       Existing
                                                          Framework
```

Cypress and Playwright are **optional adapters**, not mandatory dependencies.

---

# 5. Test Levels

DevWeave should reason across multiple test levels.

## 5.1 Unit Tests

Used for:

- Business logic
- Domain rules
- Services
- Commands
- Queries
- Handlers
- Components where appropriate

## 5.2 Integration Tests

Used for:

- Database integration
- Service integration
- Repository behavior
- Messaging
- External dependencies
- Infrastructure behavior

## 5.3 API Tests

Used for:

- HTTP endpoints
- Request validation
- Response contracts
- Authorization
- Error behavior
- API business behavior

## 5.4 Database Tests

Used where applicable for:

- Schema changes
- Constraints
- Queries
- Stored procedures
- Index behavior
- Migration behavior

## 5.5 UI / E2E Tests

Used for:

- User journeys
- Critical workflows
- UI behavior
- Cross-component behavior
- End-to-end business scenarios

Possible frameworks:

```text
Playwright
Cypress
Selenium
Existing repository framework
```

DevWeave should detect and preserve an existing framework whenever practical.

---

# 6. Existing Test Framework Detection

During ANALYZE, inspect the repository for existing testing infrastructure.

Detect, where applicable:

```text
Playwright
Cypress
Selenium
Jest
Vitest
xUnit
NUnit
MSTest
pytest
JUnit
other repository-specific frameworks
```

Also detect:

```text
test directories
test naming conventions
configuration
fixtures
test utilities
CI test commands
coverage configuration
mocking frameworks
test data
```

The repository's existing conventions should be preferred over introducing duplicate infrastructure.

---

# 7. Framework Selection Rule

DevWeave should use this decision order:

```text
Existing repository E2E framework
        ↓
Use existing framework

No existing E2E framework
        ↓
Check declared architecture/project standards
        ↓
Check approved modernization/development plan
        ↓
Recommend a suitable framework
        ↓
Human approval if introducing a new framework
```

For example:

```text
Angular + existing Cypress
        ↓
Use Cypress
```

or:

```text
Angular + existing Playwright
        ↓
Use Playwright
```

or:

```text
Angular + no E2E framework
        ↓
E2E framework decision becomes part of PLAN
```

Do not automatically add both Cypress and Playwright to the same application.

---

# 8. Test Impact Analysis

This is the central capability.

Given a user story:

```text
User Story
```

DevWeave determines:

```text
Affected source files
Affected classes/components
Affected APIs
Affected database objects
Affected business rules
Affected user journeys
Affected existing tests
Missing test scenarios
Required regression tests
```

Example:

```text
Customer creation changed
        ↓
Customer API
Customer service
Customer Angular form
Customer database mapping
        ↓
Existing tests:
CustomerServiceTests
CustomerApiTests
customer.spec.ts
        ↓
Determine which tests require modification
        ↓
Determine missing scenarios
```

---

# 9. Existing Test Update vs New Test

For every affected behavior:

```text
Does a suitable existing test exist?
        │
       YES
        │
        ↓
Does expected behavior change?
     ┌──┴──┐
    YES    NO
     │      │
     ↓      ↓
 UPDATE   KEEP
 TEST     TEST
```

If no suitable test exists:

```text
Create new test
```

DevWeave must avoid unnecessary duplicate tests.

---

# 10. Test Scenario Generation

Test scenarios should be derived from the approved story and observed behavior.

At minimum, consider:

```text
Happy path
Boundary conditions
Validation
Negative cases
Error handling
Authorization
Security
Concurrency where relevant
Persistence
Integration
Regression
UI behavior where applicable
```

Not every category is mandatory for every story.

The technology and risk profile determine applicability.

---

# 11. Example — Rate Limiting Story

User story:

> Add rate limiting to ValuesController with a maximum of 20 requests per minute.

DevWeave should identify test scenarios such as:

```text
Functional
- Request within limit succeeds
- 20th request succeeds
- 21st request is rejected

Boundary
- 19 requests
- 20 requests
- 21 requests
- Rate window reset

Error behavior
- Correct HTTP status
- Correct response
- Retry information if applicable

Security
- Different clients/users
- Relevant identity scenarios
- Relevant bypass attempts

Regression
- Existing ValuesController behavior still works
```

The actual tests should be placed at appropriate test levels.

---

# 12. Example — Customer Story

User story:

> Add a mandatory email field to Customer creation.

DevWeave may identify:

```text
Production changes
├── Customer model
├── API validation
├── Angular form
└── Database mapping

Test changes
├── Update CustomerServiceTests
├── Update CustomerApiTests
├── Update UI/E2E test
└── Add missing validation tests
```

During IMPLEMENT:

```text
Modify production code
        +
Modify affected existing tests
        +
Create missing tests
        ↓
Build
        ↓
Run affected tests
```

---

# 13. Test Plan Artifact

PLAN should generate or update the test plan as part of the implementation plan.

Example:

```yaml
testPlan:
  impactedExistingTests:
    - path: tests/CustomerServiceTests.cs
      action: UPDATE
      reason: Customer creation validation changed

  newTests:
    - path: tests/CustomerValidationTests.cs
      action: CREATE
      scenarios:
        - missing email
        - invalid email

  e2e:
    framework: Playwright
    action: UPDATE
    scenarios:
      - customer creation with valid email
      - customer creation without email

  regression:
    - customer search
    - customer edit
```

The exact schema should follow the existing DevWeave schema conventions discovered during implementation.

---

# 14. Implementation Behavior

The IMPLEMENT phase should treat production code and tests as one approved change set.

```text
Approved Plan
      ↓
Implementation
      ├── Production code
      ├── Existing test updates
      └── New tests
```

DevWeave should not wait until a separate manual test-writing phase.

---

# 15. Guard Against "Make Tests Green"

This is a mandatory safety rule.

Do NOT use:

```text
Code changed
   ↓
Tests fail
   ↓
Change tests until green
```

Instead:

```text
Approved expected behavior
        ↓
Run tests
        ↓
Failure
        ↓
Classify failure
```

Possible classifications:

```text
IMPLEMENTATION_DEFECT
TEST_DEFECT
EXPECTED_BEHAVIOR_CHANGE
ENVIRONMENT_FAILURE
UNRELATED_REGRESSION
```

Then:

```text
IMPLEMENTATION_DEFECT
    → Fix production code

TEST_DEFECT
    → Fix test with documented reason

EXPECTED_BEHAVIOR_CHANGE
    → Update test according to approved story

ENVIRONMENT_FAILURE
    → Report and stop/escalate

UNRELATED_REGRESSION
    → Preserve failure and report
```

The AI must never change a test solely to hide a production defect.

---

# 16. Test Traceability

Each generated or modified test should be traceable to the story and behavior.

Example:

```yaml
testTraceability:
  storyId: ADO-123
  behaviorId: customer-create-validation
  tests:
    - id: TEST-001
      path: tests/CustomerApiTests.cs
      type: API
      action: UPDATED

    - id: TEST-002
      path: e2e/customer.spec.ts
      type: E2E
      action: CREATED
```

This provides auditability.

---

# 17. V1.0 Integration

The normal V1.0 lifecycle becomes:

```text
CONTEXT
   ↓
ANALYZE
   ↓
Identify impacted code + tests
   ↓
PLAN
   ↓
Implementation + Test Plan
   ↓
BRANCH
   ↓
IMPLEMENT
   ├── Code
   ├── Existing test updates
   └── New tests
   ↓
PR REVIEW
   ↓
VERIFY / existing verification flow
   ↓
PR
```

Do not change existing V1.0 phase semantics unnecessarily.

Integrate Test Intelligence through existing extension points.

---

# 18. V1.1 Modernization Integration

Modernization adds behavior preservation.

```text
Legacy Application
       ↓
Discover behavior
       ↓
Discover existing tests
       ↓
Build modernization test model
       ↓
Plan target implementation
       ↓
Implement
       ├── Target code
       ├── Existing test updates
       └── New tests
       ↓
Verify
       ├── Functional behavior
       ├── Legacy behavior preservation
       └── E2E journeys
```

This makes UI/E2E tests especially valuable for page-by-page modernization.

---

# 19. Legacy-to-Modern Test Mapping

For modernization, support mappings such as:

```text
Legacy behavior
      ↓
Legacy test
      ↓
Modern behavior
      ↓
Modern test
```

Example:

```yaml
migrationTestMapping:
  sourceBehavior: legacy.customer.create
  targetBehavior: modern.customer.create
  sourceTests:
    - legacy/tests/customer-create
  targetTests:
    - modern/tests/customer-create
  status: PRESERVED
```

Possible statuses:

```text
PRESERVED
UPDATED
REPLACED
NEW
NOT_APPLICABLE
UNKNOWN
```

---

# 20. UI/E2E Test Intelligence

For modernization and normal development, DevWeave should identify user journeys.

Example:

```text
Customer
 ├── Open Customer page
 ├── Search
 ├── Add
 ├── Edit
 ├── Delete
 └── Validation
```

These become test scenarios.

Example:

```text
Scenario: Create Customer

Given the user is authenticated
When the user opens Customer
And enters valid customer information
And submits the form
Then the customer should be created
And the customer should appear in the customer list
```

The implementation framework can then be:

```text
Playwright
OR
Cypress
OR
existing framework
```

---

# 21. Test Execution Strategy

Do not always run every test after every small change.

Use test impact information.

```text
Changed files
     ↓
Affected tests
     ↓
Run focused tests
     ↓
Run broader regression
     ↓
Final verification
```

Example:

```text
Immediate:
CustomerServiceTests

Then:
CustomerApiTests

Then:
Customer E2E

Finally:
Relevant regression suite
```

The exact execution strategy should follow repository conventions and CI capabilities.

---

# 22. Token and Context Optimization

Test Intelligence must follow DevWeave's:

> Less Tokens. More Work. Lower Bill.

Do not provide every test file to every AI phase.

Use:

```text
Story
 ↓
Impact graph
 ↓
Relevant source nodes
 ↓
Relevant test nodes
 ↓
Relevant practices
 ↓
Bounded context
```

Only the required test and code context should enter the AI task.

---

# 23. Knowledge Graph Integration

Use the existing DevWeave JSON knowledge graph.

Represent relationships such as:

```text
USER_STORY
   ↓ AFFECTS
SOURCE_FILE
   ↓ COVERED_BY
TEST
   ↓ VALIDATES
BEHAVIOR
```

For UI:

```text
USER_STORY
   ↓ AFFECTS
USER_JOURNEY
   ↓ VERIFIED_BY
E2E_TEST
```

This enables future impact analysis.

---

# 24. Test Intelligence Knowledge

The repository knowledge graph should be able to represent:

```text
Test
Test Suite
Test Framework
Test Fixture
User Journey
Behavior
Source File
API
Database Object
Component
Service
```

Example relationships:

```text
TEST_COVERS
TEST_DEPENDS_ON
TEST_VALIDATES
TEST_FIXTURE_USES
USER_JOURNEY_VERIFIED_BY
STORY_AFFECTS
SOURCE_AFFECTS_TEST
```

Use the existing graph/delta architecture rather than introducing a mandatory database.

---

# 25. Technology-Aware Test Practices

The technology practice profile should include testing guidance.

Examples:

```text
Angular
- component tests where appropriate
- UI/E2E user journeys
- avoid excessive brittle DOM selectors

.NET
- unit testing
- integration testing
- API testing
- appropriate test isolation

Microservices
- service-level integration tests
- contract testing where applicable
- resilience scenarios where applicable

CQRS
- command behavior
- query behavior
- validation
- handler tests

MySQL
- persistence behavior
- constraints
- migrations
- query behavior
```

These are examples of practice categories. The actual profile must be resolved from the detected technology and version.

---

# 26. Test Quality Rules

Generated tests should be:

```text
Deterministic
Readable
Maintainable
Focused
Independent where appropriate
Repeatable
Relevant to behavior
```

Avoid:

```text
Brittle selectors
Unnecessary sleeps
Random test data without control
Hidden dependencies
Duplicate scenarios
Over-mocking
Tests that only reproduce implementation details
```

Repository-specific conventions take precedence where appropriate.

---

# 27. Human Approval

Test planning should be visible during PLAN.

Example:

```text
Test Impact Analysis

Existing tests affected: 7
Existing tests to update: 3
New unit tests: 5
New API tests: 4
New UI/E2E tests: 2
Regression suite: 31

Detected UI framework:
Playwright

Test plan is ready for approval.
```

The user can:

```text
APPROVE
REQUEST_CHANGES
PROVIDE_INFORMATION
REJECT
```

Implementation must not silently expand the approved test scope in a material way.

---

# 28. Verification Output

Verification should report:

```text
Production:
PASS

Affected existing tests:
PASS

New tests:
PASS

API:
PASS

Integration:
PASS

UI/E2E:
PASS

Regression:
PASS

Behavior preservation:
PASS
```

If something fails:

```text
FAIL

Classification:
IMPLEMENTATION_DEFECT

Affected:
CustomerApiTests

Action:
Production code requires correction.
```

---

# 29. PR Review Integration

PR review should inspect:

```text
Code changes
+
Test changes
```

The review should identify:

```text
Code changed without appropriate tests
Tests changed without corresponding story behavior
Missing boundary cases
Missing regression coverage
Suspicious test weakening
Tests deleted without justification
E2E coverage missing for affected critical journeys
```

This should be part of the existing V1.0 review architecture.

---

# 30. Implementation Steps for Google Antigravity

## Step A — Inspect

Inspect the existing:

```text
CLI
Lifecycle
Skills
Test infrastructure
Knowledge graph
State
Schemas
V1.0 verification
PR review
Antigravity adapter
```

Do not modify anything.

---

## Step B — Create the V1.1 branch

Use:

```text
feature/v1.1-modernization
```

Do not implement directly on:

```text
development
main
master
```

Verify the branch before modifying files.

---

## Step C — Identify existing test extension points

Find the exact files responsible for:

```text
Test discovery
Test planning
Implementation prompts
Verification
PR review
Technology detection
Knowledge graph
State
```

Reuse existing infrastructure.

---

## Step D — Implement Test Intelligence contracts

Add abstractions only where required.

Potential conceptual interfaces:

```text
ITestDiscovery
ITestImpactAnalyzer
ITestPlanner
ITestGenerator
ITestExecutor
ITestFrameworkDetector
ITestTraceability
```

Do not introduce these names blindly if the repository already has equivalent abstractions.

---

## Step E — Implement framework detection

Detect existing:

```text
Playwright
Cypress
Selenium
other frameworks
```

Persist the detected framework and evidence.

---

## Step F — Implement test impact analysis

Given a story:

```text
Find affected source
Find affected behavior
Find affected tests
Find missing tests
```

Use the repository knowledge graph where available.

---

## Step G — Implement test plan generation

Extend PLAN to include:

```text
Existing tests to update
New tests
Tests to retain
E2E strategy
Regression scope
```

---

## Step H — Integrate with IMPLEMENT

Ensure implementation can modify:

```text
Production code
Existing tests
New tests
```

as one approved change.

---

## Step I — Integrate with VERIFY

Execute:

```text
Focused tests
Affected tests
E2E tests
Regression tests
```

according to repository capability and test strategy.

---

## Step J — Integrate with PR REVIEW

Add test-impact review.

Ensure code/test changes remain consistent with the approved story.

---

## Step K — Add V1.1 modernization behavior mapping

Discover legacy tests and user journeys.

Map:

```text
Legacy behavior
      ↓
Legacy tests
      ↓
Modern behavior
      ↓
Modern tests
```

---

## Step L — Add test intelligence documentation

Update canonical documentation.

Document:

```text
Test Intelligence
Framework detection
Test impact analysis
Automatic test updates
Automatic new test generation
E2E strategy
Cypress
Playwright
Modernization behavior preservation
Failure classification
Test traceability
```

---

# 31. Conformance Scenarios

At minimum test these scenarios.

## Scenario 1 — Existing unit test affected

```text
Story changes business rule
→ Existing unit test detected
→ Test expected behavior changed
→ Existing test updated
```

## Scenario 2 — Missing unit test

```text
Story introduces new behavior
→ No test exists
→ New unit test created
```

## Scenario 3 — Existing API test affected

```text
API contract changes
→ Existing API tests detected
→ Relevant tests updated
```

## Scenario 4 — Existing Playwright

```text
Playwright detected
→ Existing E2E tests reused
→ Relevant tests updated
→ Missing scenarios created
```

## Scenario 5 — Existing Cypress

```text
Cypress detected
→ Existing E2E tests reused
→ Relevant tests updated
→ Missing scenarios created
```

## Scenario 6 — No E2E framework

```text
No E2E framework
→ PLAN identifies gap
→ Framework recommendation
→ Human approval
→ Framework introduced only if approved
```

## Scenario 7 — Test failure caused by production defect

```text
Test fails
→ Classified as IMPLEMENTATION_DEFECT
→ Production code corrected
→ Test remains valid
```

## Scenario 8 — Legitimate behavior change

```text
Approved story changes behavior
→ Existing test no longer represents expected behavior
→ Test updated with traceability
```

## Scenario 9 — Unrelated regression

```text
Unrelated test fails
→ Test is not weakened
→ Failure reported
→ Human decision required
```

## Scenario 10 — Modernization behavior preservation

```text
Legacy behavior discovered
→ Modern E2E scenario created
→ Modern implementation completed
→ E2E verification passes
```

---

# 32. Definition of Done

The Test Intelligence capability is complete only when:

```text
[ ] V1.0 integration works
[ ] V1.1 integration works
[ ] Existing tests are discovered
[ ] Test impact analysis works
[ ] Existing tests are automatically updated when required
[ ] Missing tests are automatically created
[ ] Unit tests are supported
[ ] Integration tests are supported
[ ] API tests are supported
[ ] Database tests are supported where applicable
[ ] UI/E2E tests are supported
[ ] Existing E2E frameworks are detected
[ ] Cypress adapter capability exists
[ ] Playwright adapter capability exists
[ ] Both are not forced on one application
[ ] Test strategy is part of PLAN
[ ] Tests are changed alongside implementation
[ ] Test failures are classified
[ ] AI cannot weaken tests merely to make them green
[ ] Test traceability exists
[ ] Knowledge graph can represent test relationships
[ ] Modernization behavior preservation works
[ ] Focused test execution works
[ ] Regression execution works
[ ] PR review checks test impact
[ ] V1.0 regression passes
[ ] V1.1 modernization tests pass
[ ] Documentation is synchronized
```

# 33. Final Principle

The final DevWeave behavior should be:

```text
                    USER STORY
                         ↓
                UNDERSTAND CHANGE
                         ↓
                 IMPACT ANALYSIS
                         ↓
            ┌────────────┴────────────┐
            ↓                         ↓
       Production Code          Existing Tests
            ↓                         ↓
            └────────────┬────────────┘
                         ↓
                  TEST PLAN
                         ↓
                    APPROVAL
                         ↓
                  IMPLEMENT
                  /        \
                 /          \
          CODE CHANGES    TEST CHANGES
                 \          /
                  \        /
                    ↓
                  VERIFY
                    ↓
             TEST + REGRESSION
                    ↓
                    PR
```

**DevWeave should treat tests as a first-class part of the software change.**

When production behavior changes, DevWeave should automatically determine which existing tests need updating and which new tests are required, then implement those test changes alongside the production code under the same approved story and plan.
