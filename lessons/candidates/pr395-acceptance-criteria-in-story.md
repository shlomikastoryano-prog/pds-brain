# Lesson candidate: Every acceptance criterion can be checked in Storybook

Status: candidate, single occurrence. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`).

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
