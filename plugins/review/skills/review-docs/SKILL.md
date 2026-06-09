---
name: review-docs
description: Review the repository's prose documentation (README files, docs/, adr/) for drift from the code, broken internal links, bloat, and content that belongs in code. Read-only — produces a findings report, never edits. Use only on explicit request such as "review the docs", "check the docs are up to date", or "audit documentation".
---

Review the repository's prose documentation and report what needs maintenance. This
is a **read-only review**: produce a findings report, never edit a doc.

## Scope

Review **prose documentation only**, found in conventional locations:

- `README*` at any depth
- everything under `docs/`
- everything under `adr/`

By default review **all** such files. If the user passes a path or glob, review only
that.

Code is the **source of truth**, not a review target. Read code freely to judge the
prose, but never report findings about the code itself — only about prose.

## What to look for

Report findings in these four categories:

1. **Drift from code** — prose that contradicts the actual repo: wrong commands,
   renamed or removed files/flags/APIs, outdated paths, examples that no longer work,
   structure sections that omit or misname directories.
2. **Internal consistency** — broken relative links, references to files or sections
   that no longer exist, and contradictions between two docs.
3. **Succinctness / actionability** — documentation must tell the reader *what to do*,
   not *why*. Flag background, rationale, and elaboration that don't drive action. For
   example, install instructions should show the steps, not explain why they were
   chosen. Keep this to clear-cut bloat, not borderline tone or style nitpicks.
4. **Right layer / non-duplication** — prose must only add what code cannot express.
   Flag prose that repeats what is already documented in code (e.g. an API whose
   behavior is already in docstrings/signatures), or content that belongs in code
   instead of prose.

## Quality bar

**Report only high-confidence findings, verified against the code.** Before listing a
drift or right-layer finding, open the relevant code and confirm it — that the command,
path, flag, or API actually is wrong, removed, or already documented in code. Drop
speculative or "maybe" issues entirely; do not include a low-confidence tier. A short,
trustworthy report beats a long, noisy one.

## Output

Print the report **in chat only** — do not write any files.

Default grouping is **by file**. For each doc with findings, list each finding as:

- **Location** — `file:line` or the section heading
- **Category** — one of the four above
- **Problem** — what is wrong, stated concisely
- **Recommended action** — the concrete fix, described but **not applied**

If the user asks, group **by category** instead (all drift together, all link issues
together, etc.).

If there are no findings, output **only** a single short line such as "No issues found."
Do not recap what was checked, restate verified content, or list the categories — a
clean result is just that one line.
