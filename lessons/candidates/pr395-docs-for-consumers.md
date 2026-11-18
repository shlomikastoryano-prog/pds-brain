# Lesson candidate: Write consumer-facing trade-offs in the docs, not only in the PR notes

Status: candidate. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`). Checked against other PRs on 2026-11-18, not yet confirmed (see Verification).

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

### Verification (2026-11-18, full comment text): weak, stays a candidate
- **PR 395:** the reviewer asked for the guidance in the docs, twice. Clear match.
- **PR 385, comment 886441518, "Lower priority":** "a one-line note in the docs would help" about a horizontal scrollbar when the container has less than 12px side padding. A match, but marked lower priority.
- **PR 394, comment 893112618:** point 2: "Neither is listed under 'Behavior change'" (no place given). Point 5: "Consider documenting that only these two hosts are auto-detected" (no place given, and only "consider"). Partial.
- **PR 379, comment 883678812:** the Props table in the docs must be complete and correct. A different request, covered by Anat 9 (PR 379 is already listed there). Not counted.
- **PR 373:** accuracy of the docs. A different request. Not counted.
- **Result:** 2 PRs with a real match (395 and 385), but only 395 asks for it with weight. Keep as a candidate until a stronger repeat.
