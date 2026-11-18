# Lesson candidate: Code comments must match what the code does

Status: ready for reviewer approval. It repeated in another PR (see Occurrences), so it meets the repeat rule in `guidelines/learning-loop.md`. Not a lesson until the reviewer approves it.

### Code comments must match what the code does
- **Do:** when you write a comment that explains a fallback, a limit or a side effect, check it against the code.
- **Avoid:** a comment that promises something the code does not do.
- **Why:** a wrong comment misleads the next reader. In PR 394 it also hid a real bug.
- **Example:** a comment said `preventDefault()` lets a surrounding dialog know the Esc key was used, but the dialog's own listener never checks `defaultPrevented`, so both the popup and the modal close.
- Seen in: PR 395, 394

### Evidence (checked against the full comment text, 2026-11-18)
- **PR 395:** a comment said that without `:has()` "only this rule is dropped", but the wide-table block also depends on `:has()`. The comment was corrected.
- **PR 394, comment 892846749:** "The comment in onEscape says the `preventDefault()` call lets a surrounding dialog know the Esc was used. That is not the case for the dialog in this repo". Full match.
- **PR 394, comment 893112618, point 3:** "Either drop minWidth from the inline style or adjust the comment so it matches what actually happens". Same PR, same lesson.
- **PR 383:** the PR description contradicted the code. This is the existing lesson Anat 8 (description matches the final code), not a code comment, so it is not counted here.

### Proposal details
- **Occurrences:** 2 PRs (395 and 394), exactly at the threshold.
- **Matching lesson in the brain:** Anat 8 and Accessibility 6 cover PR descriptions and docs, not code comments.
- **Missed despite a lesson:** no. Written before the brain existed.
- **Fits our code:** yes, the examples are from this repo.
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson), or a sentence added to Anat 8.
- **Person's decision:** pending.
