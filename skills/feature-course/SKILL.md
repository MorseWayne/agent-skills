---
name: feature-course
description: Create a progressive, top-down, multi-perspective course for an already implemented feature. Use when the user has built or "vibed" a feature and wants to deeply learn its requirements, architecture, frontend, backend, API contracts, code flow, tests, risks, glossary, and important concepts through coarse-to-fine lessons.
license: MIT
metadata:
  author: MorseWayne
  version: "1.0.0"
  domain: software-engineering
  type: learning-workflow
  mode: course-generator
---

# Feature Course

Create a **progressive course** for an implemented feature so the user can truly understand and own it.

This skill is for the moment after a feature has been shipped, prototyped, or generated with AI and the user says:

- "我 vibe 了一个需求，但想彻底掌握它"
- "帮我自顶向下学习这个功能"
- "我想知道这个需求的前端、后端、架构和代码是怎么串起来的"
- "帮我做一套循序渐进的课程，不要一上来淹没在源码细节里"

## Core Teaching Principle

Teach in this order:

```text
先全局，后局部
先意图，后实现
先主干，后分支
先职责，后源码
先正常路径，后异常路径
先会讲，后会改
```

Never start by dumping source code. First build the learning map, then progressively zoom in.

## Required Outputs

Persist the course to files unless the user explicitly asks for chat-only output.

Default output location:

```text
docs/feature-courses/<feature-name>/
```

For small features, you may ask whether to write a single file instead:

```text
docs/feature-courses/<feature-name>.md
```

Use this directory structure for substantial features:

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
    └── <concept-name>.md
```

Before writing, if the feature name or output location is unclear, ask one focused question.

## Workflow

### Phase 0: Orient and Scope

1. Identify the feature name, user goal, and known entry points.
2. Inspect existing docs first if present: `README.md`, `docs/**`, `CONTEXT.md`, ADRs, design docs, API docs.
3. Inspect code only after forming an initial map.
4. Prefer semantic/navigation tools when available:
   - CodeGraph for symbol search, call graphs, impact, affected tests, and task-focused context.
   - GitNexus for execution flows and architecture exploration.
   - Targeted grep/read only after the likely files are known.

If the codebase can answer a question, inspect the code before asking the user.

### Phase 1: Build the Learning Map

Create `00-learning-map.md` first. It must be understandable without reading source code.

Include:

- feature in one sentence
- why it exists
- who uses it
- learning goals
- prerequisite concepts
- perspective map: product, architecture, frontend, backend, contract, code, tests, change
- recommended lesson order
- files/modules that will appear later, without deep explanation yet

### Phase 2: Product / Requirements View

Create `01-product-view.md`.

Explain:

- problem being solved
- user story
- trigger/action/result
- V1 scope
- explicit non-goals
- constraints and assumptions
- acceptance criteria in Given/When/Then format

Do not describe implementation details in this lesson except as links to later lessons.

### Phase 3: Architecture View

Create `02-architecture-view.md`.

Explain the system shape before showing code:

- where the feature lives in the system
- participating modules and their responsibilities
- boundaries and seams
- dependencies and direction of calls
- high-level data flow
- important state transitions
- coupling points and risks

Use simple diagrams when helpful:

```text
User Action
  ↓
Frontend Page / Component
  ↓
API Contract
  ↓
Backend Handler
  ↓
Application / Domain Logic
  ↓
Storage / External Service
  ↓
Response / Side Effect
```

If the feature is frontend-only or backend-only, still explain the architectural boundaries inside that side.

### Phase 4: Frontend View

Create `03-frontend-view.md` when the feature has UI, client state, client routing, browser behavior, or frontend API calls.

Teach from coarse to fine:

```text
Page / route entry
↓
Component tree
↓
User event
↓
Local/global state
↓
Data fetching / mutation / cache
↓
UI feedback: loading / error / empty / success
```

Include:

- route/page entry points
- component responsibilities
- event flow
- state ownership
- API call sites
- validation and formatting
- loading/error/empty/success states
- accessibility or UX concerns if visible
- file paths for each conclusion

Do not line-by-line explain components until the user has the component map.

### Phase 5: Backend View

Create `04-backend-view.md` when the feature has API routes, commands, persistence, auth, domain rules, jobs, queues, or external services.

Teach from coarse to fine:

```text
Route / command / message entry
↓
Request parsing and validation
↓
Auth / permission checks
↓
Application service
↓
Domain rule
↓
Repository / DB / external service
↓
Response / side effect
```

Include:

- backend entry points
- request schema and validation
- permission model
- core business logic
- persistence or external dependencies
- errors and failure modes
- retries, idempotency, transactions, concurrency, or consistency if relevant
- file paths for each conclusion

### Phase 6: Contract View

Create `05-contract-view.md` when frontend and backend communicate, or when two modules depend on a shared schema/protocol.

Explain:

- request shape
- response shape
- error shape
- type/schema source of truth
- frontend usage locations
- backend definition locations
- compatibility risks
- what changes if the contract changes

Include a matrix:

```markdown
| Contract | Producer / Definition | Consumer | Risk if changed | Evidence |
|---|---|---|---|---|
```

Important: distinguish an **API contract** from an implementation function. A contract is the shared promise between producer and consumer.

### Phase 7: Code Walkthrough View

Create `06-code-walkthrough.md` only after architecture and perspective lessons exist.

Walk through code in three levels:

1. Key file map
2. Key function/class/module responsibilities
3. Core code excerpts and explanation

For every important code block, answer:

- which requirement it serves
- input
- output
- dependencies
- invariants
- likely change points
- risk if modified

Avoid dumping large files. Quote small snippets only when necessary.

### Phase 8: Test and Risk View

Create `07-test-view.md`.

Explain:

- what tests exist
- what each test proves
- which acceptance criterion each test maps to
- what is not covered
- frontend tests vs backend tests vs integration/e2e tests
- most likely regressions

Include:

```markdown
| Acceptance criterion | Frontend test | Backend test | Integration/E2E test | Coverage status | Gap |
|---|---|---|---|---|---|
```

If tests are absent, propose a learning-oriented test plan without silently adding tests unless asked.

### Phase 9: Change Playbook

Create `08-change-playbook.md`.

Teach how to safely modify the feature:

```text
Level 1: copy/text/config/display change
Level 2: add or change one field/state
Level 3: add one branch or edge case
Level 4: change API/module contract
Level 5: refactor an architectural boundary
```

For each level, include:

- files likely to change
- why those files
- tests to add/update
- risks
- rollback or verification strategy

### Phase 10: Teach-back Check

Create `09-teach-back.md`.

The final goal is not that the agent explained it. The final goal is that the user can explain it.

Include questions in increasing difficulty:

1. Explain the feature in five sentences.
2. Draw the happy path from user action to final result.
3. Name the three most important modules and their responsibilities.
4. Explain the frontend state flow, if applicable.
5. Explain the backend request/data flow, if applicable.
6. Explain the contract between producer and consumer.
7. Name two edge cases and where they are handled.
8. Name one test that should fail if the feature breaks.
9. Describe how you would implement a small change.
10. Describe what you would be afraid of breaking.

When using this skill interactively, ask teach-back questions one at a time. Provide a recommended answer after the user attempts or asks for help.

## Concept Explanation System

Important terms and obscure concepts must have a place for detailed explanation.

Maintain two artifacts:

```text
glossary.md                 # short lookup explanations
concept-notes/<concept>.md  # deeper explanations for hard concepts
```

### When to Add to `glossary.md`

Add a glossary entry when a term is important but can be explained briefly, such as:

- API contract
- component state
- domain rule
- repository
- DTO
- schema
- route handler
- optimistic update
- cache invalidation
- debounce/throttle
- transaction
- idempotency
- eventual consistency
- dependency injection
- seam
- adapter
- invariant
- e2e test

Use this format:

```markdown
## <Term> / <中文名>

一句话：<plain explanation>

在本需求中：<how it appears in this feature>

相关位置：
- <path>

容易误解：
- <common misunderstanding>
```

### When to Add `concept-notes/<concept>.md`

Add a concept note when the concept is hard, cross-cutting, or likely to block understanding.

Use this format:

```markdown
# <Concept> / <中文名>

## 一句话理解

## 它解决什么问题

## 为什么这个需求里需要它

## 在代码里的体现

## 前端视角

## 后端视角

## 架构视角

## 如果不理解它，会出什么 bug

## 和相近概念的区别

## 自测题
```

If a concept only applies to frontend or backend, omit irrelevant subsections.

### Concept Rules

1. Do not assume the user understands professional jargon.
2. Explain an important term the first time it appears.
3. Every lesson must include a `本课涉及概念` section linking to `glossary.md` or `concept-notes/`.
4. Concept explanations must use the current feature as the example, not only abstract definitions.
5. If a concept means different things in frontend, backend, and architecture, explain those differences.
6. If a term is fuzzy or overloaded, choose a canonical term and use it consistently.

## Lesson Format

Each lesson should follow this shape:

```markdown
# Lesson <N>: <Title>

## 学习目标

## 一句话理解

## 本课涉及概念

## 相关代码位置

## 核心图解

## 逐步讲解

## 常见误解

## 你现在应该能回答的问题

## 小练习

## 下一课
```

Lessons should be short enough to learn in one sitting. Prefer multiple small lessons over one giant document.

## Perspective Rules

1. If the feature involves UI, generate a frontend view.
2. If the feature involves API/data/business rules/jobs/external services, generate a backend view.
3. If the feature crosses modules, generate an architecture view.
4. If producer and consumer communicate through request/response/schema/events, generate a contract view.
5. Code walkthrough must come after architecture and perspective views.
6. Tests must be mapped back to requirements.
7. Every claim about implementation must cite evidence: file path, symbol, test, config, or documentation.
8. Never modify production code unless the user explicitly asks.

## Interaction Style

- Ask one focused question at a time when information is missing.
- Provide your recommended answer when asking the user to choose.
- If the user asks to learn interactively, teach only the next lesson, then ask a checkpoint question.
- If the user asks for a full course, write all course files first, then summarize the learning path.
- Use Chinese by default when the user uses Chinese.
- Be concrete and path-oriented. Show file paths clearly.

## Quality Bar

A successful course lets the user:

- explain why the feature exists
- explain the happy path without reading code
- identify frontend, backend, architecture, and contract responsibilities
- find the key files quickly
- explain important concepts in their own words
- name covered and uncovered tests
- make a small change safely
- know what might break

If the course does not enable those outcomes, refine it before finalizing.

## References

Additional templates and checklists:

- [Course Output Template](references/course-output-template.md)
- [Perspective Checklist](references/perspective-checklist.md)
- [Concept Note Guide](references/concept-note-guide.md)
