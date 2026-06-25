# MorseWayne Agent Skills

A small collection of agent skills for engineering work and deliberate learning.

The repository follows the open Agent Skills layout used by projects such as `mattpocock/skills`: each skill lives in a directory with a `SKILL.md`, and the repository can be installed with the Skills CLI through `npx`.

## Quick Start

Install all skills interactively:

```bash
npx skills@latest add MorseWayne/agent-skills
```

Install all skills globally without prompts:

```bash
npx skills@latest add MorseWayne/agent-skills --global --yes
```

Install only `feature-course`:

```bash
npx skills@latest add MorseWayne/agent-skills --skill feature-course --global --yes
```

Equivalent full GitHub URL form:

```bash
npx skills@latest add https://github.com/MorseWayne/agent-skills --skill feature-course --global --yes
```

After installation, restart your coding agent or run its reload command so it discovers the new skill.

For Pi:

```text
/reload
```

Then use:

```text
/skill:feature-course
```

## Installation Guide

### Prerequisites

- Node.js and `npx` available in your shell.
- A coding agent that supports Agent Skills, or a Skills CLI target supported by `skills.sh`.
- For Pi users, skill commands should be enabled. They are enabled by default in recent Pi versions.

Check `npx`:

```bash
npx --version
```

### Option 1: Interactive install

Use this when you want the installer to ask which skills and agent targets to install to:

```bash
npx skills@latest add MorseWayne/agent-skills
```

The installer will discover skills in this repository and let you choose where to install them.

### Option 2: Non-interactive global install

Use this when you want a repeatable setup command:

```bash
npx skills@latest add MorseWayne/agent-skills --global --yes
```

Flags:

- `--global` / `-g`: install at the user level instead of only the current project.
- `--yes` / `-y`: skip confirmation prompts.

### Option 3: Install one skill

Install only the progressive feature learning course skill:

```bash
npx skills@latest add MorseWayne/agent-skills --skill feature-course --global --yes
```

Install only the Go design review skill:

```bash
npx skills@latest add MorseWayne/agent-skills --skill go-design-review --global --yes
```

### Option 4: Install from a local checkout

Useful when developing or testing this repository:

```bash
git clone https://github.com/MorseWayne/agent-skills.git
cd agent-skills
npx skills@latest add "$PWD" --skill feature-course
```

### Updating

Re-run the install command to refresh the installed copy:

```bash
npx skills@latest add MorseWayne/agent-skills --global --yes
```

Then restart or reload your agent.

## Available Skills

### `feature-course`

Create a progressive, top-down, multi-perspective course for an already implemented feature.

Use it when a feature was built quickly, prototyped, or generated with heavy AI assistance, and you now want to truly own it.

It teaches a feature through multiple views:

- product / requirements view
- architecture view
- frontend view
- backend view
- frontend-backend contract view
- code walkthrough view
- test and risk view
- change and evolution view
- glossary and deep concept notes

Example prompt:

```text
/skill:feature-course
我 vibe 了「XXX需求」，请按自顶向下、先粗后细、多视角的方式，为我生成循序渐进课程。重点覆盖前端、后端、架构、代码、测试，以及重要概念的详细解释。
```

Expected course output in the target project:

```text
docs/feature-courses/<feature-name>/
├── 00-learning-map.md
├── 01-product-view.md
├── 02-architecture-view.md
├── 03-frontend-view.md
├── 04-backend-view.md
├── 05-contract-view.md
├── 06-code-walkthrough.md
├── 07-test-view.md
├── 08-change-playbook.md
├── 09-teach-back.md
├── glossary.md
└── concept-notes/
```

### `go-design-review`

Review Go backend requirement and design documents for consistency and design quality without reading implementation code.

Use it for:

- requirement review
- design document review
- README / SPEC / Design / Proto / SQL consistency checks
- backend design quality checks before implementation

Example prompt:

```text
/skill:go-design-review
帮我检查 docs/ 下的 Go 后端设计文档，重点看 README、SPEC、Design、Proto 和 SQL 是否一致。不要读取 Go 源码。
```

> Note: this repository currently keeps the historical directory name `go-design-reviw/` for compatibility, but the skill name is `go-design-review`.

## Repository Layout

```text
.
├── README.md
├── package.json
├── go-design-reviw/
│   └── SKILL.md
└── skills/
    └── feature-course/
        ├── SKILL.md
        └── references/
```

## Verifying a Skill Is Installed

In Pi or another compatible agent, try the slash command:

```text
/skill:feature-course
```

If the command is not found:

1. Restart or reload the agent.
2. Confirm the install command completed successfully.
3. Re-run the install command with `--global --yes`.
4. For Pi, check that skill commands are enabled in settings.

## Security Note

Skills can instruct an agent to read files, write files, run commands, or use helper scripts depending on the agent and the skill content. Review skills before installing or using them, especially from third-party repositories.
