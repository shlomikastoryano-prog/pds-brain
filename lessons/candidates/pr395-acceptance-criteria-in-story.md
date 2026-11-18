# Lesson candidate: Every acceptance criterion can be checked in Storybook

Status: candidate. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`). Checked against other PRs on 2026-11-18, not yet confirmed (see Verification).

### Every acceptance criterion can be checked in Storybook
- **Do:** make sure a story lets you check each acceptance criterion of the ticket. Bind the table inputs the criterion needs, such as hover or selection.
- **Avoid:** story controls that are not bound to anything, so a criterion cannot be checked.
- **Why:** the reviewer could not check the wide-table hover case in Storybook.
- **Example:** a wide-table story with 22 columns, `rowHover: true` and `selectionMode: 'multiple'`, so the hover criteria can be checked.
- Seen in: PR 395

### Proposal details
- **Source comment:** PR 395 (SHELL-719), comments of the team reviewer, 2026-11-02 to 2026-11-16.
- **What happened:** The reviewer asked for it in the first round (story controls) and again in the third round (AC2 and AC5 cannot be checked).
- **Occurrences:** asked in two rounds of PR 395 (counts as one occurrence)
- **Matching lesson in the brain:** Anat 9 (Storybook: show only controls that affect the story) and Mayank 12 (follow the ticket) are close but do not say that each criterion must be checkable in a story.
- **Missed despite a lesson:** no. The brain was not in use when this PR was written, and no lesson covered it.
- **Fits our code:** to be verified (found from the review comments only, without the PR diff).
- **Target file:** to be decided if it repeats.
- **Person's decision:** pending.

### Verification (2026-11-18): not confirmed as a separate lesson
- **PR 381, comment 885026190:** controls that do nothing in most stories. This is the existing lesson Anat 9 (PR 381 is already listed there). It covers the "Avoid" side only.
- **PR 391, comment 905032915:** refers to the acceptance criteria through the manifest, not through a story that lets you check them. Partial.
- **PR 385, comment 886441518:** "No automated tests for the acceptance criteria". Not read in full.
- The distinct claim of this candidate (each acceptance criterion can be checked in a story) was not found in another PR.
- **Idea:** add a sentence to Anat 9 instead of a new lesson. To be decided with the reviewer.
