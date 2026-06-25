# MorseWayne Agent Skills

A small collection of agent skills for engineering work and deliberate learning.

## Install

Install interactively with the Skills CLI:

```bash
npx skills@latest add MorseWayne/agent-skills
```

Install a specific skill:

```bash
npx skills@latest add https://github.com/MorseWayne/agent-skills --skill feature-course
```

After installation, restart or reload your coding agent so it can discover the new skill.

## Skills

### `feature-course`

Create a progressive, top-down, multi-perspective course for an already implemented feature. It is designed for situations where a feature was built quickly or with heavy AI assistance and you now want to truly own it.

It teaches the feature from multiple views:

- product / requirements view
- architecture view
- frontend view
- backend view
- frontend-backend contract view
- code walkthrough view
- test and risk view
- change and evolution view
- glossary and deep concept notes

Recommended prompt:

```text
/skill:feature-course
我 vibe 了「XXX需求」，请按自顶向下、先粗后细、多视角的方式，为我生成循序渐进课程。重点覆盖前端、后端、架构、代码、测试，以及重要概念的详细解释。
```

### `go-design-review`

Review Go backend requirement and design documents for consistency and design quality without reading implementation code.

> Note: this repository also contains the historical directory `go-design-reviw/` for compatibility.
