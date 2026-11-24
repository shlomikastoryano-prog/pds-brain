# Lesson candidate: Every path that changes two-way state must emit its change

Status: single occurrence. Not a lesson, and the agents that write code do not read it. Moved from the pre-check agent's lessons skill (`phenom-ds-review-lessons`, written 2026-10-26) while comparing it with the brain. By the repeat rule in `guidelines/learning-loop.md` it waits for a second PR. All six candidates from this comparison come from PR 383 and the same reviewer. If the reviewer prefers one lesson on emits and state sync, they can be merged.

### Every path that changes two-way state must emit its change
- **Do:** for each input `x` that has an output `xChange`, make every code path that changes `x` emit `xChange` with the new value. This includes user events, programmatic methods such as `clear()` or `reset()`, and lifecycle resets.
- **Avoid:** a method that changes the internal field and does not emit.
- **Why:** the parent keeps the old value and silently goes out of sync.
- **Example:** `clear()` sets `selectAll = null` without emitting `selectAllChange(null)`. A parent that holds `true` is never told.
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
