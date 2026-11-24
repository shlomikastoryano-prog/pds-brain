# Lesson candidate: Cover a handler that throws or calls back during a series of emits

Status: single occurrence. Not a lesson, and the agents that write code do not read it. Moved from the pre-check agent's lessons skill (`phenom-ds-review-lessons`, written 2026-10-26) while comparing it with the brain. By the repeat rule in `guidelines/learning-loop.md` it waits for a second PR. All six candidates from this comparison come from PR 383 and the same reviewer. If the reviewer prefers one lesson on emits and state sync, they can be merged.

### Cover a handler that throws or calls back during a series of emits
- **Do:** for a method that emits two or more outputs, add a spec with a handler that throws and one that calls back into the component (`clear()`, a toggle), or record the gap in a follow-up ticket.
- **Avoid:** assuming every consumer handler returns normally and never calls back.
- **Why:** a throw leaves the state half-updated because later emits never run, and a callback runs in the middle of the sequence.
- **Example:** a parent handler for the first emit calls `toggleAllRows()` before the second emit has run.
- Seen in: PR 383

### Proposal details
- **Source comment:** PR 383 (SHELL-677), as recorded in the lessons skill. Not re-read against the full comment text (to be verified).
- **Reviewer:** Anat
- **Occurrences:** single occurrence (PR 383)
- **Matching lesson in the brain:** Mayank 14 covers handler loops, not throws.
- **Missed despite a lesson:** no
- **Fits our code:** to be verified (the components were not re-read in this comparison)
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson)
- **Person's decision:** pending
- **Note:** the reviewer said this could be a follow-up, so it may stay a ticket and not become a lesson.
