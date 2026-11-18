# Lesson candidate: One concern per PR

Status: candidate. Found while reading comments for the PR 395 candidates, so it did not come from PR 395. It meets the repeat rule (2 PRs), but no search was made for it in other PRs. A targeted search is pending.

### One concern per PR
- **Do:** keep a PR to one concern. A separate concern gets its own PR and its own ticket. When a PR depends on another one, merge or rebase after it so the diff contains only this PR's change.
- **Avoid:** a PR that bundles several changes, or that still contains another PR's commit.
- **Why:** the reviewer cannot judge each change on its own. For example, a large SCSS move that is mostly indentation hides the real changes.
- **Example:** "five changes: popup stays open, X clear sync, Esc handling, dialog auto-appendTo, and a ~400-line SCSS move". The reviewer preferred the dialog work "as its own PR and ticket".
- Seen in: PR 394, 391

### Evidence (checked against the full comment text, 2026-11-18)
- **PR 394, comment 893112618, point 7:** "This PR now contains five changes ... The dialog work is a separate concern from the Calgary time-picker blocker. Since the dialog issue is less urgent ... I'd prefer it as its own PR and ticket." The comment also asks to mention reviewing the SCSS diff with `git diff -w`.
- **PR 391, comment 905032915, "Hygiene":** "PR 390's b6e80166 is still in this diff, so please merge or rebase after it so this PR is Button-only before approval."

### Proposal details
- **Occurrences:** 2 PRs (394 and 391), different authors.
- **Matching lesson in the brain:** none.
- **Missed despite a lesson:** no. Written before the brain existed.
- **Fits our code:** this is about PR process, not code.
- **Next:** search the reviewer's comments in other PRs for requests to split a PR or to remove a foreign commit.
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson), and maybe a line in the definition of done.
- **Person's decision:** pending.
