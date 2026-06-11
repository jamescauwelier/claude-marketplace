---
name: setup-env
description: Configures the environment with the necessary data to run skills in this plugin. Other skills will express their dependency on this skill at which point it should be triggered per their specification.
disable-model-invocation: true
---

This outlines the different configuration steps needed to make the skills in this plugin work.

## How to use the setup configuration

Different items may need configuration. Each of the "Setup Steps" need to be run. However, when re-running this skill, after it has already written all `docs/<config>.md` files, provide the option to update an existing configuration.

If running for the first time, go over each setup step, one by one, and follow instructions there.

Be extremely verbose. Drop all prose. Use lists and select boxes everywhere possible for selection. Do not explain anything, just ask for the values of configuration options and visualize valid options. Error messages, if any, should be 
extremely concise.

## Setup Steps

### 1. Issue Tracker

To get access to issues, we need a ticket tracker. Only one option is available, namely Linear. Follow the instructions in `setup-linear.md` to properly compose a ticket tracking solution.

### 2. Triage Labels

> Explainer: When the triage skill processes an incoming issue, it moves it through a state machine — needs evaluation, waiting on reporter, ready for an AFK agent to pick up, ready for a human, or won't fix. To do that, it needs to 
> apply labels (or the equivalent in your issue tracker) that match strings you've actually configured. If your repo already uses different label names (e.g. bug:triage instead of needs-triage), map them here so the skill applies the right ones instead of creating duplicates.

The five canonical roles:

needs-triage — maintainer needs to evaluate
needs-info — waiting on reporter
ready-for-agent — fully specified, AFK-ready (an agent can pick it up with no human context)
ready-for-human — needs human implementation
wontfix — will not be actioned
Default: each role's string equals its name. Ask the user if they want to override any. If their issue tracker has no existing labels, the defaults are fine.

Write a document `docs/agents/triage-labels.md` using the seed template `triage-labels.md`.

### 3. Domain Docs

> Explainer: Some skills (`improve-codebase-architecture`, `diagnose`, `tdd`) read a `CONTEXT.md` file to learn the project's domain language, and `docs/adr/` for past architectural decisions. They need to know whether the repo has one global context or multiple (e.g. a monorepo with separate frontend/backend contexts) so they look in the right place.

Confirm the layout:

- **Single-context** — one `CONTEXT.md` + `docs/adr/` at the repo root. Most repos are this.
- **Multi-context** — `CONTEXT-MAP.md` at the root pointing to per-context `CONTEXT.md` files (typically a monorepo).

Read `domain.md` for instructions and context around structuring domain knowledge and context. After confirming the layout, document the choice and write decisions to `docs/agents/domain.md`.

## Persist

Our setup steps write files to `docs/agents/*.md`, but we must also link to these files to make them accessible to our agents.

Add the following section to `CLAUDE.md`:

```markdown
## Agent skills

### Issue Tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

If an `Agent skills` header already exists, replace it with the above instead.