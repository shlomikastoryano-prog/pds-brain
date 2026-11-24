# Lesson candidate: Do not change an existing emit between a reference and a copy

Status: single occurrence. Not a lesson, and the agents that write code do not read it. Moved from the pre-check agent's lessons skill (`phenom-ds-review-lessons`, written 2026-10-26) while comparing it with the brain. By the repeat rule in `guidelines/learning-loop.md` it waits for a second PR. All six candidates from this comparison come from PR 383 and the same reviewer. If the reviewer prefers one lesson on emits and state sync, they can be merged.

### Do not change an existing emit between a reference and a copy
- **Do:** keep what an existing output emits (the same reference, or a copy) unless a ticket changes it. New outputs emit copies.
- **Avoid:** changing `this.x` to `[...this.x]` on an existing output inside a bug fix, or the other way round.
- **Why:** consumers may rely on identity (`===`, `trackBy`, memoized selectors).
- **Example:** a fix that starts emitting a copy of the selection breaks a parent that compares it with its own array by reference.
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
