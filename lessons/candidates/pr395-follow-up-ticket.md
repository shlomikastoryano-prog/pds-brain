# Lesson candidate: A deferred item gets a follow-up ticket, linked in the PR notes

Status: candidate, single occurrence. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`).

### A deferred item gets a follow-up ticket, linked in the PR notes
- **Do:** when you defer work to a follow-up, create the ticket and write its number in the PR notes. State what the ticket covers.
- **Avoid:** writing "deferred to a follow-up" with no ticket number.
- **Why:** reason not given in the comment. Without a number, the deferred item cannot be tracked.
- **Example:** "play-function assertions deferred to SHELL-858", and "SHELL-819 covers blockFor, the padding assertion and emptyStateArgTypes".
- Seen in: PR 395

### Proposal details
- **Source comment:** PR 395 (SHELL-719), comments of the team reviewer, 2026-11-02 to 2026-11-16.
- **What happened:** Play-function assertions were deferred with no ticket id. The reviewer later asked to create or link the ticket, and asked whether the padding assertion was part of the existing follow-up.
- **Occurrences:** asked in three comments of PR 395 (counts as one occurrence)
- **Matching lesson in the brain:** none
- **Missed despite a lesson:** no. The brain was not in use when this PR was written, and no lesson covered it.
- **Fits our code:** to be verified (found from the review comments only, without the PR diff).
- **Target file:** to be decided if it repeats.
- **Person's decision:** pending.
