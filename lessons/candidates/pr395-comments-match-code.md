# Lesson candidate: Code comments must match what the code does

Status: candidate, single occurrence. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`).

### Code comments must match what the code does
- **Do:** when you write a comment that explains a fallback or a limit, check it against the code.
- **Avoid:** a comment that says only one rule is affected when a second rule depends on the same condition.
- **Why:** reason not given in the comment. A wrong comment misleads the next reader.
- **Example:** a comment said that without `:has()` "only this rule is dropped", but the wide-table block is also keyed on `:has()`, so both fixes are dropped.
- Seen in: PR 395

### Proposal details
- **Source comment:** PR 395 (SHELL-719), comments of the team reviewer, 2026-11-02 to 2026-11-16.
- **What happened:** The reviewer asked to correct the comment in the second round, and the comment was corrected.
- **Occurrences:** single comment in PR 395
- **Matching lesson in the brain:** Accessibility 6 (docs and stories describe only what the code does) and Anat 8 (PR description matches the final code) cover docs and PR descriptions, not code comments.
- **Missed despite a lesson:** no. The brain was not in use when this PR was written, and no lesson covered it.
- **Fits our code:** to be verified (found from the review comments only, without the PR diff).
- **Target file:** to be decided if it repeats.
- **Person's decision:** pending.
