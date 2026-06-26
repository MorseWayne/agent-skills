# Tool Matrix

Tools are optional. Missing tools should be recorded and skipped.

## Generic

| Tool | Purpose | Safe default command |
| --- | --- | --- |
| `tokei` | Language/code size summary | `tokei <repo>` |
| `cloc` | Language/code size summary | `cloc <repo>` |
| `scc` | Code size/complexity summary | `scc <repo>` |
| `semgrep` | Security/rule scanning | `semgrep scan --config auto <repo>` |
| `gitleaks` | Secret detection | `gitleaks detect --source <repo> --no-git` |

## JavaScript / TypeScript

| Tool | Purpose |
| --- | --- |
| `knip` | Unused files, exports, dependencies |
| `jscpd` | Duplicate code detection |
| `madge` | Circular dependency detection and dependency graph |
| `dependency-cruiser` / `depcruise` | Dependency rules and architecture boundaries |
| `eslint` / `biome` | Lint and complexity rules |

## Python

| Tool | Purpose |
| --- | --- |
| `ruff` | Lint and basic quality |
| `radon` | Complexity and maintainability index |
| `vulture` | Dead code candidates |
| `bandit` | Security scan |
| `import-linter` | Enforced import contracts |

## Go

| Tool | Purpose |
| --- | --- |
| `go vet` | Standard correctness checks |
| `staticcheck` | Advanced static analysis |
| `gocyclo` | Cyclomatic complexity |
| `govulncheck` | Vulnerability analysis |
| `gosec` | Security scan |

## Networked Tool Execution

Do not use `npx`, `pnpm dlx`, `uvx`, `go install`, or package-manager installation commands unless the user explicitly approves network access and dependency installation.
