# Personal Claude skills

## Development Guidelines

### Branching strategy

Never work on the `main` branch, but always develop on a custom local branch. When merging, squash commits with an
informative commit message. Always push commits merged into main, never push the branches. This is a simple repo and only needs a very simple branching strategy.

## Agent skills

### Issue Tracker

Issues are tracked in Linear (via the Linear MCP), scoped to the `Engineering` team, `ZoneAI` initiative, projects with status `Planned`/`In Progress`. See `docs/agents/issue-tracker.md`.

### Triage labels

The five canonical triage roles map 1:1 to identically-named labels under the `Agents` parent group in the Engineering team. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context layout — one `CONTEXT.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.