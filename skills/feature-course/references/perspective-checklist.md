# Perspective Checklist

Use this checklist to ensure each feature course has the right views.

## Product / Requirements

- Problem
- User
- Trigger
- Result
- Scope
- Non-goals
- Given/When/Then

## Architecture

- System placement
- Module responsibilities
- Boundaries/seams
- Dependency direction
- Data flow
- State transitions
- Coupling and risk

## Frontend

- Route/page
- Component tree
- User event
- State ownership
- API/mutation/cache
- Validation and formatting
- Loading/error/empty/success
- Accessibility/UX notes

## Backend

- Route/command/message entry
- Request parsing
- Validation
- Auth/permission
- Application/domain logic
- Persistence/external dependency
- Response and errors
- Idempotency/transaction/concurrency if relevant

## Contract

- Request shape
- Response shape
- Error shape
- Schema/type source
- Producer
- Consumer
- Compatibility risk

## Code

- Key file map
- Key symbol responsibilities
- Small core snippets
- Inputs/outputs/invariants
- Change points and risks

## Tests

- Acceptance criteria mapping
- Frontend tests
- Backend tests
- Integration/e2e tests
- Missing coverage
- Regression risks

## Change

- Level 1 display/config change
- Level 2 field/state change
- Level 3 branch/edge case
- Level 4 contract change
- Level 5 boundary refactor
