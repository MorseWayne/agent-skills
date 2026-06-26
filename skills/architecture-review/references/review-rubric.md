# Review Rubric

Use this rubric to make findings comparable and decision-ready.

## Severity

| Severity | Meaning |
| --- | --- |
| Critical | Likely correctness, data integrity, security, or release-blocking risk. |
| High | Significant maintainability, reliability, or change-risk problem. |
| Medium | Noticeable friction or likely future cost. |
| Low | Local cleanup or documentation/tooling improvement. |

## Confidence

| Confidence | Meaning |
| --- | --- |
| High | Supported by direct code/tool evidence and clear impact. |
| Medium | Supported by evidence but impact or best fix needs validation. |
| Low | Plausible pattern; needs domain confirmation. |

## Effort

| Effort | Meaning |
| --- | --- |
| S | Small local cleanup, usually one module. |
| M | Several files, clear migration path. |
| L | Cross-cutting refactor, requires tests and staged rollout. |
| XL | Architectural initiative; needs planning/ADR. |

## Risk of Change

| Risk | Meaning |
| --- | --- |
| Low | Well-tested or isolated. |
| Medium | Some callers/tests; manageable with targeted validation. |
| High | Many callers, weak tests, critical path, or data migration. |

## Recommendation Strength

| Strength | Meaning |
| --- | --- |
| Strong | Evidence is clear and the next step is likely worth doing soon. |
| Worth exploring | Evidence indicates friction, but design needs a short spike. |
| Speculative | Keep as observation; do not act without more evidence. |

## Priority Heuristic

Prefer findings with:

1. High confidence
2. High locality improvement
3. Clear deletion/consolidation path
4. Low to medium change risk
5. Ability to add tests around a stable interface first

Avoid starting with:

- broad rewrites,
- framework migrations,
- speculative abstractions,
- changes that contradict ADRs without strong evidence,
- critical paths with no test safety net.
