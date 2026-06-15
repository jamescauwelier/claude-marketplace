---
name: merge-pr
description: Triggered when asking to accept or merge  a PR to fold it into a target branch. Encode additional tasks or procedures to hook into the process.
---

# merge-pr

Fold a feature branch into its target branch — but only after the linked issue's acceptance criteria are verified against the branch and checked off. Acceptance criteria are a gate: if any are unmet, the merge is **refused**.

## Input

`$ARGUMENTS` may name the branch to merge and/or the target branch. If nothing is given:

- **Source branch:** the current branch (`git rev-parse --abbrev-ref HEAD`).
- **Target branch:** `main` (the repository convention).

Never run this skill with the source branch equal to the target — per the repo branching strategy, work always merges *from* a feature branch *into* `main`.

## Steps

1. **Derive the issue identifier from the branch name.** The branch follows the `<ISSUE>/<slug>` convention (see the `branch` skill). The issue identifier is the leading token before the first `/` — e.g. `WEB-2` from `WEB-2/app-skeleton-boots-and-routes`. It must match `[A-Z]+-?\d+` and is used **verbatim**.

   If the branch has no `<ISSUE>/` prefix, stop and ask the user which issue this branch implements. Do not guess.

2. **Fetch the issue.** Use the Linear issue tracker (`get_issue` with the identifier), per `docs/agents/issue-tracker.md`. Read the full description and any sub-items.

3. **Locate the acceptance criteria.** These are markdown checklist items in the issue description — lines of the form `- [ ] …` (unmet) or `- [x] …` (met), typically under a heading like *Acceptance Criteria*, *Done when*, or *Definition of Done*.

   - If the issue has **no checklist**, there are no criteria to gate on. Note this to the user and proceed straight to the merge (step 6).
   - If a checklist exists, every item is a gate — including ones already marked `[x]` (re-verify them; do not trust the prior state blindly).

4. **Verify each criterion against the branch.** Inspect what the branch actually changed relative to the target:

   ```
   git diff main...<source-branch>
   git log main..<source-branch> --oneline
   ```

   For each criterion, judge from the diff, the code, tests, and — where it's the only way to be sure — by running the relevant tests or app. Classify each as:
   - **met** — the branch demonstrably satisfies it;
   - **unmet** — the branch does not satisfy it, or there is no evidence it does.

   Be conservative: if you cannot find evidence a criterion is satisfied, it is **unmet**. Do not give the benefit of the doubt.

5. **Decide the gate.**

   - **All criteria met →** check every item off in the ticket by updating the issue description so each line reads `- [x] …` (`save_issue`/`update_issue`). Then continue to step 6.
   - **Any criterion unmet →** do **not** modify the checklist and do **not** merge. Emit the refusal message (see *Refusal message* below) and stop.

6. **Merge via the GitHub API.** Use the GitHub MCP rather than local `git` — this keeps the merge server-side and avoids any history-rewriting commands (`reset`, force-push, local squash).

   1. **Find the PR** for the source branch: `list_pull_requests` filtered by `head` (the source branch, `state: open`). If none exists, stop and tell the user to open a PR first — this skill merges PRs, it does not create them. If more than one matches, ask which.
   2. **Squash-merge it:** `merge_pull_request` with `merge_method: "squash"` and an informative, issue-referencing commit title and body:
      - `commit_title`: e.g. `WEB-2: app skeleton boots and routes`
      - `commit_message`: a short summary of the change.

   The squash keeps `main`'s history linear with one commit per PR. GitHub performs the merge server-side — nothing is rewritten or force-pushed locally.

7. **Close the loop.** Move the issue status to _Done_ in Linear. Report to the user: the issue merged, the criteria verified, and the squash commit that landed on `main`.

## Refusal message

When criteria are unmet, the merge is blocked. The message must communicate *why* clearly and succinctly. Use this structure:

```
🚫 Merge refused — <ISSUE> acceptance criteria not met

Branch:   <source-branch> → <target-branch>
Issue:    <ISSUE> <title>

Unmet (N of M):
  ✗ <criterion text> — <one-line reason no evidence was found>
  ✗ <criterion text> — <one-line reason>

Met:
  ✓ <criterion text>

Next: address the unmet criteria on the branch, then re-run merge.
```

Keep each reason to a single line. List only the unmet criteria's reasons in full; the met ones need no justification. The ticket checklist is left untouched so it still reflects reality.

## Notes

- The acceptance-criteria gate is the point of this skill. Never merge past an unmet criterion, and never silently check a box you could not verify.
- The merge happens server-side through the GitHub API (`merge_pull_request`, squash). Avoid local history-rewriting commands — no `reset`, no force-push, no local `merge --squash`. Read-only `git diff`/`git log` for verification (step 4) are fine.
- If the PR is not mergeable (conflicts, failing required checks, behind base), surface that to the user rather than forcing it through.
