# Lesson candidate: Do not recreate objects or redo work on every change detection or input change

Status: candidate. Not a lesson yet. The wording was widened after the check on 2026-11-18, and the reviewer has not seen the wider version. It was first written as "rebuild derived data only when its source input changes".

### Do not recreate objects or redo work on every change detection or input change
- **Do:** rebuild a derived value only when the input it comes from changed (check `SimpleChanges`, or use a setter). Memoize a value that a getter returns, and compare by identity before redoing work.
- **Avoid:** a getter or `ngOnChanges` that creates a new object or array on every pass, or work that is repeated on every selection change.
- **Why:** the child gets a new input on every pass and re-renders, which can lose state such as column widths and sort state, and costs time on large tables.
- **Example:** rebuild `columns` only when `columnCount` changes, not when rows, loading or the header change.
- Seen in: PR 395, 388, 394

### Evidence (checked against the full comment text, 2026-11-18). All three are partial matches of the wider idea.
- **PR 395:** the demo's `ngOnChanges` rebuilt `columns` on every input change, so the table re-rendered its headers and lost widths and sort state.
- **PR 388, comment 887204490, point 3:** every selection change resets and re-attaches the buttons several times. "A cheap fix: skip the reset when the actions array identity, width and counts are unchanged."
- **PR 394, comment 893112618, point 4:** "resolvedPanelStyle returns a new object each time, so p-calendar sees a changed panelStyle input on every pass". The suggested fix is to memoize the panel style object (keyed on `this.panelStyle`) and compute `insideOverlayHost` once. Confirmed after reading the full comment (3428 characters).
- No PR matched the narrow wording (`ngOnChanges` rebuilding a derived array).

### Proposal details
- **Occurrences:** 3 PRs with a partial match of the wider wording.
- **Matching lesson in the brain:** Mayank 1 (no plain function calls from templates) is the same family: work that runs on every change detection.
- **Missed despite a lesson:** no. Written before the brain existed.
- **Fits our code:** yes, the examples are from this repo.
- **Open question for the reviewer:** is the wider wording right, or should the narrow one stay a candidate?
- **Target file:** `lessons/by-reviewer/lessons-anat.md`, or an addition to Mayank 1.
- **Person's decision:** pending.
