# Lesson candidate: Rebuild derived data only when its source input changes

Status: candidate, single occurrence. Not a lesson yet. It becomes a lesson when it repeats in another PR (see `guidelines/learning-loop.md`).

### Rebuild derived data only when its source input changes
- **Do:** in `ngOnChanges`, rebuild a derived value only when the input it comes from changed (check `SimpleChanges`, or use a setter).
- **Avoid:** rebuilding it on every input change.
- **Why:** the component gets a new array each time and re-renders, which loses column widths and sort state.
- **Example:** rebuild `columns` only when `columnCount` changes, not when rows, loading or the header change.
- Seen in: PR 395

### Proposal details
- **Source comment:** PR 395 (SHELL-719), comments of the team reviewer, 2026-11-02 to 2026-11-16.
- **What happened:** Seen in a demo component of a story, in the second round.
- **Occurrences:** single comment in PR 395
- **Matching lesson in the brain:** none
- **Missed despite a lesson:** no. The brain was not in use when this PR was written, and no lesson covered it.
- **Fits our code:** to be verified (found from the review comments only, without the PR diff).
- **Target file:** to be decided if it repeats.
- **Person's decision:** pending.
