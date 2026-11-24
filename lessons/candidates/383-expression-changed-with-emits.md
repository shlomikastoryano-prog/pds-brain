# Lesson candidate: Check for ExpressionChanged errors when emits run from a parent's lifecycle hook

Status: single occurrence. Not a lesson, and the agents that write code do not read it. Moved from the pre-check agent's lessons skill (`phenom-ds-review-lessons`, written 2026-10-26) while comparing it with the brain. By the repeat rule in `guidelines/learning-loop.md` it waits for a second PR. All six candidates from this comparison come from PR 383 and the same reviewer. If the reviewer prefers one lesson on emits and state sync, they can be merged.

### Check for ExpressionChanged errors when emits run from a parent's lifecycle hook
- **Do:** if a change adds or moves emits in a method that also calls `detectChanges()` or `markForCheck()`, add a test that calls the method from a parent's `ngAfterViewInit` or `ngOnInit` and checks that there is no console error.
- **Avoid:** reordering emits around `detectChanges()` without that test.
- **Why:** in dev mode Angular throws `ExpressionChangedAfterItHasBeenChecked` when the call comes from a parent lifecycle hook.
- **Example:** a table method that emits and then calls `detectChanges()` is called from a parent's `ngAfterViewInit`.
- Seen in: PR 383

### Proposal details
- **Source comment:** PR 383 (SHELL-677), as recorded in the lessons skill. Not re-read against the full comment text (to be verified).
- **Reviewer:** Anat
- **Occurrences:** single occurrence (PR 383)
- **Matching lesson in the brain:** Anat 3 covers a `detectChanges` call without a reason, not this risk.
- **Missed despite a lesson:** no
- **Fits our code:** to be verified (the components were not re-read in this comparison)
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson)
- **Person's decision:** pending
