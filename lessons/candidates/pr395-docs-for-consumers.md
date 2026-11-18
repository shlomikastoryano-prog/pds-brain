# Lesson candidate: Write consumer-facing trade-offs in the docs, not only in the PR notes

Status: candidate, single occurrence. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`).

### Write consumer-facing trade-offs in the docs, not only in the PR notes
- **Do:** when a change has a trade-off that consumers of the library must handle, write it in the component docs. Put it in the PR notes as well.
- **Avoid:** putting the guidance only in the PR notes.
- **Why:** consumers read the docs, not the PR notes.
- **Example:** a table that cannot scroll sideways while empty gets a docs sentence: "provide a clearing action (for example 'Clear filters') whenever filters or search can lead to an empty state".
- Seen in: PR 395

### Proposal details
- **Source comment:** PR 395 (SHELL-719), comments of the team reviewer, 2026-11-02 to 2026-11-16.
- **What happened:** The reviewer asked for it in the first round (docs and PR notes). Only the PR notes were updated, so the reviewer asked again in the second round.
- **Occurrences:** repeated twice inside PR 395 (counts as one occurrence)
- **Matching lesson in the brain:** Naresh 5 and Mayank 4 (explain removal of behaviour, explain every change) cover the PR notes, not the docs.
- **Missed despite a lesson:** no. The brain was not in use when this PR was written, and no lesson covered it.
- **Fits our code:** to be verified (found from the review comments only, without the PR diff).
- **Target file:** to be decided if it repeats.
- **Person's decision:** pending.
