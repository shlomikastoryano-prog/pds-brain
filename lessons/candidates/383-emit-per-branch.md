# Lesson candidate: Emit inside each branch, not with a flag that skips a later emit

Status: single occurrence. Not a lesson, and the agents that write code do not read it. Moved from the pre-check agent's lessons skill (`phenom-ds-review-lessons`, written 2026-10-26) while comparing it with the brain. By the repeat rule in `guidelines/learning-loop.md` it waits for a second PR. All six candidates from this comparison come from PR 383 and the same reviewer. If the reviewer prefers one lesson on emits and state sync, they can be merged.

### Emit inside each branch, not with a flag that skips a later emit
- **Do:** when one path has modes (lazy or not, cross-page or single-page), put the emit inside the branch where it belongs.
- **Avoid:** setting a flag and then skipping a trailing emit with `if (!flag)`.
- **Why:** it hides which events fire in which mode, and makes order mistakes easier. The reviewer marked it as minor, a readability point.
- **Example:** `const crossPage = ...; ... if (!crossPage) { this.x.emit(...) }` becomes an emit inside `if (!crossPage) { ... }`.
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
- **Note:** weak candidate. The reviewer called it minor.
