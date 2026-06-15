---
name: branch
description: Create a git branch from an issue identifier and title, named `<ISSUE>/<slug-of-title>` (e.g. WEB-2/app-skeleton-boots-and-routes). Use when the user wants to start work on a tracked issue and needs a correctly-named branch. This includes analysis tickets where ADR's or other docs might be added.
---

# branch

Create a git branch for a tracked issue. The branch name is the **issue identifier**, a slash, then a **slug of the issue title**:

```
WEB-2/app-skeleton-boots-and-routes
```

This matches the repository convention (e.g. the existing `WEB-1/decides-web-frontend-setup`).

## Input

`$ARGUMENTS` is an issue reference. Accept any of:

- An identifier plus title: `WEB-2 App skeleton boots and routes (Vite + React)`
- A bare identifier: `WEB-2` — in this case look the title up via the Linear issue tracker (`get_issue`), per `docs/agents/issue-tracker.md`.

If no issue identifier can be determined, ask the user for one. Do not invent it.

## Steps

1. **Parse the issue identifier.** It is the leading token matching `[A-Z]+-?\d+` (e.g. `WEB-2`). Preserve it verbatim, including the dash — do **not** strip it to `WEB2`.

2. **Get the title.** Use the title text following the identifier in the arguments. If only an identifier was given, fetch the issue from Linear and use its title.

3. **Slug the title:**
    - Lowercase.
    - Drop a leading parenthetical/qualifier only if it's noise; otherwise keep the meaningful words.
    - Replace every run of non-alphanumeric characters with a single `-`.
    - Trim leading/trailing `-`.
    - Truncate to roughly 6–8 words / ~50 chars at a word boundary so the branch stays readable.

   Example: `App skeleton boots and routes (Vite + React + TS strict + Router, pnpm)` → `app-skeleton-boots-and-routes`.

4. **Compose the branch name:** `<ISSUE>/<slug>` → e.g. `WEB-2/app-skeleton-boots-and-routes`.

5. **Create and switch to it** from the current branch:

   ```
   git checkout -b <ISSUE>/<slug>
   ```

   If a branch with that name already exists, switch to it (`git checkout <name>`) instead of failing, and tell the user it already existed.

6. **Move ticket status:** moves the ticket status from _Todo_ to _In Progress_. Starting a branch means work is starting on it. If the current status is not _Todo_ or _In Progress_, also alert the user to this.

7. **Report** the branch name created and confirm the working tree moved to it.

## Notes

- Never push the branch as part of this skill — only create it locally. Pushing happens later, when the user asks.
- Keep the slug ASCII-only.
- pro-actively create branches for analysis tickets, even if there might not be anything to commit (we can ignore the branch later)
