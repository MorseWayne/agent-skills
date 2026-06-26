---
name: architecture-review
description: Perform a whole-codebase architecture and code quality review. Use when the user wants Claude or another coding agent to autonomously inspect a project for AI/vibe-coding bloat, redundancy, shallow modules, over-abstraction, dead code, duplicated code, dependency boundary problems, testability gaps, and maintainability risks. Review-only by default; do not modify production code unless explicitly asked.
license: MIT
metadata:
  author: MorseWayne
  version: "1.0.0"
  domain: software-engineering
  type: architecture-review
  mode: read-only-review
---

# Architecture Review

Perform a **whole-codebase architecture and implementation quality review** for projects that may have grown quickly through AI-assisted or vibe coding.

The goal is to answer:

- Is the project bloated or redundant?
- Are modules deep enough to justify their interfaces?
- Are abstractions useful, premature, or fake?
- Which code is duplicated, unused, dead, or only pass-through glue?
- Where are dependency boundaries, tests, and maintainability weak?
- What should be fixed first, and what should not be touched yet?

## Non-Negotiable Safety Rules

1. **Review-only by default.** Do not edit production code, tests, configuration, package manifests, migrations, or generated artifacts during the review unless the user explicitly asks for implementation.
2. **Ask before destructive or networked actions.** Ask before deleting files, installing tools, running package-manager commands that download dependencies, changing lockfiles, or writing reports into the repository.
3. **Prefer temporary outputs.** If a file report is useful, write it to the OS temp directory unless the user asks for a repo-local report.
4. **Evidence required.** Every major finding must cite files, symbols, commands, metrics, or code excerpts.
5. **Separate facts from judgement.** Tool results are evidence; architectural interpretation is analysis. Mark uncertainty clearly.
6. **Do not chase every smell.** Prioritize the few issues with the highest leverage and confidence.

## When to Use

Use this skill when the user says things like:

- "这个 AI vibe coding 项目代码量不可控，帮我整体 review"
- "帮我找冗余代码、死代码、坏抽象和架构问题"
- "不要先改代码，先给我一个架构和代码质量报告"
- "Is this codebase over-engineered or full of shallow modules?"
- "Review the whole project, not just a PR"

For pull-request-only review, prefer a PR review workflow. This skill is for **whole-project understanding and architecture-quality diagnosis**.

## Required Workflow

### Phase 0: Scope and Ground Rules

1. Confirm the target repository root.
2. Determine whether the user wants:
   - chat-only summary,
   - Markdown report in temp directory,
   - HTML/Markdown report in the repository,
   - or a CI-ready tool configuration proposal.
3. If the request is broad, proceed without asking many questions. Ask only when the target project or output location is ambiguous.

### Phase 1: Read Existing Project Guidance

Read these first when present:

- `README.md`
- `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `.windsurfrules`
- `CONTEXT.md`, `ARCHITECTURE.md`
- `docs/adr/**`, `docs/architecture/**`, `docs/design/**`
- package manifests, build/test config, CI config

Respect existing architectural decisions. If a recommendation conflicts with an ADR, label it explicitly and explain why the friction may justify reopening the decision.

### Phase 2: Detect Project Shape

Identify:

- languages and frameworks
- package manager/build system
- service boundaries, apps, packages, modules, libraries
- test framework and test locations
- generated code directories
- migration/schema/API contract locations
- monorepo structure if present

If this skill's helper scripts are available, you may run:

```bash
./scripts/detect-project.sh <repo-root>
```

Run it from the skill directory, passing the target repository root.

### Phase 3: Collect Objective Evidence

Use available tools, but do not fail if they are missing. Record missing tools in the report.

Recommended helper scripts:

```bash
./scripts/run-common-scans.sh <repo-root>
./scripts/run-js-ts-scans.sh <repo-root>       # if JS/TS is present
./scripts/run-python-scans.sh <repo-root>      # if Python is present
./scripts/run-go-scans.sh <repo-root>          # if Go is present
./scripts/collect-summary.sh <scan-output-dir>
```

The scripts are designed to skip unavailable tools. They write to a temporary output directory by default.

Objective evidence to collect:

- code size and language mix
- largest files and directories
- duplicate code
- unused dependencies/exports/dead code
- circular dependencies
- dependency boundary violations
- high-complexity functions
- lint/static-analysis/security findings
- test coverage or test-to-code ratio when available
- changed/hot files if git history is relevant

### Phase 4: Architecture Analysis

Use the vocabulary below consistently:

- **Module**: anything with an interface and implementation, from function to package.
- **Interface**: everything callers must know to use the module, not just a type signature.
- **Implementation**: the code behind the interface.
- **Depth**: leverage behind a small interface. Deep modules hide complexity; shallow modules expose or merely shuffle it.
- **Seam**: a place behavior can vary without editing callers.
- **Adapter**: a concrete implementation at a seam.
- **Locality**: how well change, bugs, and knowledge are concentrated.
- **Leverage**: how much behavior callers get for little interface cost.

Look for:

- shallow modules and pass-through services
- over-fragmented files created only to look organized
- god modules and generic `utils`, `helpers`, `manager`, `service` objects
- fake interfaces with only one adapter and no plausible second adapter
- duplicate validation, mapping, API clients, DTOs, hooks, components, repositories, or workflow code
- domain logic scattered across controllers, UI, jobs, and persistence layers
- technical layers that ignore domain concepts
- cyclic dependencies or forbidden inward/outward dependencies
- generated code mixed with human-authored code
- test suites that mock implementation details instead of testing stable interfaces
- features where one small requirement change would require edits across many unrelated files

Use the deletion test:

> If this module were deleted, would complexity disappear, concentrate somewhere sensible, or reappear across many callers?

If deleting a module merely removes indirection, it is probably shallow. If deleting it spreads complex behavior across callers, it is earning its keep.

### Phase 5: Rank Findings

For each finding, include:

- **Severity**: Critical / High / Medium / Low
- **Confidence**: High / Medium / Low
- **Impact**: user/business/runtime/maintenance impact
- **Effort**: S / M / L / XL
- **Risk**: risk of changing it
- **Recommendation strength**: Strong / Worth exploring / Speculative

Prioritize high-confidence, high-locality, high-leverage fixes before broad rewrites.

### Phase 6: Produce the Report

Use `references/report-template.md`.

The report must include:

1. Executive summary
2. Project overview
3. What was scanned and what was skipped
4. Objective metrics
5. Architecture findings
6. Redundancy/dead-code/duplication findings
7. Dependency and boundary issues
8. Testability and quality risks
9. Top refactoring candidates
10. Things not to touch yet
11. Continuous enforcement recommendations
12. Suggested next steps

End with exactly these sections:

```markdown
## Top 3 Changes to Make First
## Top 3 Things Not to Touch Yet
## Suggested Next Prompt
```

## Tool Policy

Prefer already-installed local tools. Do not install tools unless the user approved it.

If the user approves networked one-off tools, these are useful examples:

### Generic

- `tokei`, `cloc`, `scc` for code size
- `semgrep` for rule/security scans
- `gitleaks` for secret detection
- `sonar-scanner` or SonarQube MCP when configured

### JavaScript / TypeScript

- `knip` for unused files/exports/dependencies
- `jscpd` for duplicate code
- `madge` for circular dependencies and dependency graphs
- `dependency-cruiser` for enforceable dependency rules
- `eslint` or `biome` for lint/complexity

### Python

- `ruff` for lint
- `radon` for complexity/maintainability
- `vulture` for dead code candidates
- `bandit` for security
- `import-linter` for architecture contracts

### Go

- `go test`, `go vet`
- `staticcheck`
- `gocyclo`
- `govulncheck`
- `gosec`

## Output Style

- Use the user's language by default.
- Be concrete and path-oriented.
- Prefer tables for prioritized findings.
- Do not overclaim. Label speculation.
- Avoid generic advice like "improve modularity" unless tied to evidence and a specific next step.
- Recommend deletion or consolidation when that is safer than adding more abstractions.
- Do not produce a massive unranked smell list; produce a decision-ready report.

## References

- [Architecture Smells](references/architecture-smells.md)
- [Review Rubric](references/review-rubric.md)
- [Report Template](references/report-template.md)
- [Tool Matrix](references/tool-matrix.md)
