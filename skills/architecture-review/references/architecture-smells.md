# Architecture Smells

Use this checklist to identify architectural friction. A smell is not automatically a defect; it is a prompt for evidence-based analysis.

## Shallow Modules

A module is shallow when callers must understand almost as much as the implementation to use it.

Signals:

- The module mostly forwards calls to another module.
- The interface has many parameters but little behavior.
- The implementation is shorter than the setup required by callers.
- The module exists only so tests can mock it.
- Deleting the module would remove indirection without spreading meaningful complexity.

Recommended action: delete, inline, or merge into the caller/owned module unless it is a real seam.

## Fake Seams and Single-Adapter Interfaces

A seam is only valuable if behavior can realistically vary.

Signals:

- An interface has exactly one implementation and no near-term second adapter.
- Callers depend on the concrete behavior anyway.
- Tests mock the interface but production cannot swap it.
- The interface mirrors every method of the implementation.

Recommended action: collapse the seam, or deepen it so callers depend on a smaller domain concept.

## Over-Fragmentation

Signals:

- Understanding one domain concept requires opening many tiny files.
- Files are split by technical category rather than behavior locality.
- The call chain is mostly `controller -> service -> manager -> helper -> util` with little logic at each step.
- A small feature change touches many files that do not represent distinct decisions.

Recommended action: consolidate around domain concepts and stable interfaces.

## God Modules

Signals:

- A file or class handles unrelated responsibilities.
- It imports from many distant areas of the codebase.
- It is a frequent source of merge conflicts.
- Most changes eventually touch it.

Recommended action: split by cohesive responsibility only after identifying real seams and tests.

## Utility Gravity Wells

Signals:

- `utils`, `helpers`, or `common` contains domain behavior.
- Utility functions require domain context hidden in naming or comments.
- Callers compose many utilities in repeated patterns.

Recommended action: move behavior into domain modules that own invariants.

## Duplicate Domain Logic

Signals:

- Validation exists in UI, API handlers, services, and database logic with subtle differences.
- DTO/type definitions are copied instead of generated or shared intentionally.
- Mapping logic is repeated across endpoints or jobs.
- Error handling and retry policies are reimplemented per caller.

Recommended action: centralize invariants behind a small interface or generate from a single source of truth.

## Boundary Drift

Signals:

- Lower-level modules import UI/API concerns.
- Domain code depends on infrastructure details without an adapter.
- Feature folders import each other's internals.
- Cycles exist between packages that should be layered.

Recommended action: define dependency rules and enforce them with tooling.

## Testability Smells

Signals:

- Tests need many mocks for one behavior.
- Tests assert internal call order instead of externally visible behavior.
- Important behavior can only be tested through end-to-end tests.
- Refactors break tests without changing behavior.

Recommended action: test through stable interfaces; deepen modules so the interface is the test surface.

## AI/Vibe-Coding Specific Smells

Signals:

- Multiple versions of the same solution live side by side.
- Comments explain intended behavior that the code does not enforce.
- Generic abstractions were created before there were multiple use cases.
- Files are named professionally but contain pass-through or duplicated code.
- New code avoids touching old code by adding another layer.

Recommended action: prefer deletion, consolidation, and invariant ownership before adding abstractions.
