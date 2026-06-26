# Architecture Review Report: {project-name}

Generated: {date}
Reviewer: architecture-review skill

## Executive Summary

- Overall assessment: {healthy / manageable / risky / high-risk}
- Main risk: {one sentence}
- Best first move: {one sentence}
- Do not start with: {one sentence}

## Project Overview

| Item | Value |
| --- | --- |
| Repository root | `{repo-root}` |
| Primary languages | {languages} |
| Frameworks | {frameworks} |
| Package/build tools | {tools} |
| Test setup | {tests} |
| Docs/ADRs found | {docs} |

## Review Scope

### Included

- {paths / modules / commands}

### Skipped or Unavailable

- {missing tools / excluded generated files / unread paths}

## Objective Metrics

| Metric | Result | Evidence |
| --- | --- | --- |
| Code size | {result} | {command/path} |
| Largest files | {result} | {command/path} |
| Duplicate code | {result} | {command/path} |
| Dead/unused code | {result} | {command/path} |
| Circular dependencies | {result} | {command/path} |
| Static analysis | {result} | {command/path} |
| Tests/coverage | {result} | {command/path} |

## Architecture Findings

| ID | Finding | Severity | Confidence | Recommendation |
| --- | --- | --- | --- | --- |
| A1 | {finding} | {severity} | {confidence} | {strength} |

### A1. {Finding Title}

- **Files**: `{path}`, `{path}`
- **Evidence**: {code/tool evidence}
- **Why it matters**: {impact on locality/leverage/change risk}
- **Diagnosis**: {shallow module / fake seam / boundary drift / etc.}
- **Suggested next step**: {delete / merge / isolate / deepen / test first / leave unchanged}
- **Effort**: {S/M/L/XL}
- **Risk of change**: {Low/Medium/High}

## Redundancy, Dead Code, and Duplication

| ID | Evidence | Likely Action | Confidence |
| --- | --- | --- | --- |
| R1 | {evidence} | {delete/merge/verify} | {confidence} |

## Dependency and Boundary Issues

- {cycles, forbidden imports, layering drift, monorepo package issues}

## Testability and Quality Risks

- {hard-to-test areas, missing tests for refactor candidates, mocks indicating bad seams}

## Top Refactoring Candidates

| Rank | Candidate | Why first | Guardrail |
| --- | --- | --- | --- |
| 1 | {candidate} | {leverage} | {test/metric/rollback} |

## Things Not to Touch Yet

- {critical but risky area}: {reason and prerequisite}

## Continuous Enforcement Recommendations

- {tool/config/check to add later}

## Top 3 Changes to Make First

1. {change}
2. {change}
3. {change}

## Top 3 Things Not to Touch Yet

1. {area}
2. {area}
3. {area}

## Suggested Next Prompt

```text
请基于 architecture review 报告，先针对优先级最高的候选项做一个不改代码的重构方案：列出目标接口、迁移步骤、需要补的测试、风险和回滚方式。
```
