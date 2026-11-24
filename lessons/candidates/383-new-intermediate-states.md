# Lesson candidate: Check what a subscriber sees between two emits

Status: single occurrence. Not a lesson, and the agents that write code do not read it. Moved from the pre-check agent's lessons skill (`phenom-ds-review-lessons`, written 2026-10-26) while comparing it with the brain. By the repeat rule in `guidelines/learning-loop.md` it waits for a second PR. All six candidates from this comparison come from PR 383 and the same reviewer. If the reviewer prefers one lesson on emits and state sync, they can be merged.

### Check what a subscriber sees between two emits
- **Do:** when a change adds or reorders emits, write down the parent's state after each emit. If an in-between state means something wrong on its own, document it and test it with a subscriber that is not synchronous.
- **Avoid:** assuming the parent only looks at the final state.
- **Why:** a store observer or an analytics hook can act on the in-between state.
- **Example:** emitting `selectionChange` before `selectAllChange` leaves a moment with a page-only selection and `selectAll = null`, which a store reads as a page selection.
- Seen in: PR 383

### Proposal details
- **Source comment:** PR 383 (SHELL-677), as recorded in the lessons skill. Not re-read against the full comment text (to be verified).
- **Reviewer:** Anat
- **Occurrences:** single occurrence (PR 383)
- **Matching lesson in the brain:** none
- **Missed despite a lesson:** no
- **Fits our code:** to be verified (the components were not re-read in this comparison)
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson)
- **Person's decision:** pending
