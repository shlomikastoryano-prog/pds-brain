# Review lessons: Anat

Status: draft, not yet approved.
Source: 30 review comments in 17 merged PRs, 2026-09-14 to 2026-11-05. Long comments were read only in part.
Format: Do / Avoid / Why / Example. Examples are short illustrations written from the review comment, not copied code.

## 1. Use tokens, not hard-coded values
- **Do:** use the shadow and color tokens.
- **Avoid:** hard-coded color values in shadows.
- **Why:** tokens keep themes consistent and change in one place.
- **Example:** `box-shadow: var(--<shadow-token>)` instead of `box-shadow: 0 2px 8px rgba(0,0,0,.2)`.
- Seen in: PR 355.

## 2. Clean up resources on destroy
- **Do:** cancel `requestAnimationFrame` in `ngOnDestroy`. Attach document-level listeners only while the component is visible or active.
- **Avoid:** `@HostListener('document:focusin')` that runs app-wide all the time.
- **Why:** the handler runs on every focus change in the app, even when the component is hidden.
- **Example:** `ngOnDestroy() { cancelAnimationFrame(this.rafId); }`
- Seen in: PR 355, 382.

## 3. Remove unnecessary code
- **Do:** before adding code, ask if it is needed. Remove unused functions, unreachable branches and redundant methods.
- **Avoid:** a `detectChanges` call without a reason, and a handler that only forwards an event.
- **Why:** dead code hides real logic. An unreachable branch that sets state without syncing can leave the component inconsistent if it ever runs.
- **Example:** bind `(onBlur)="onBlurEvent.emit($event)"` in the template instead of a method that only calls `emit`.
- Seen in: PR 355, 389, 400.

## 4. Keep layout stable
- **Do:** give bars a `min-width`. Put captions in a container with a max width and an ellipsis.
- **Avoid:** long text that pushes neighbouring controls.
- **Why:** without limits the layout breaks at narrow widths (shown with screenshots in the review).
- **Example:** `.caption { max-width: …; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }`
- Seen in: PR 355, 365.

## 5. Add and strengthen tests
- **Do:** add tests to every enhancement. A guard test starts from the state the guard protects.
- **Avoid:** a guard test that starts from an empty state.
- **Why:** from an empty state the test passes even if the guard is removed.
- **Example:** to test "ignore `checked: true`", start with `selectAll = true` and a non-empty `selection`, then assert both are unchanged.
- Seen in: PR 365, 389.

## 6. Check state edge cases
- **Do:** before opening the PR, run through: no inline actions, an async parent (store, `setTimeout`, OnPush with async pipe), an internal filter with zero matches, `clear()` after a filter, a fast menu reopen, a fit skipped while a menu is open.
- **Avoid:** assuming the parent updates state synchronously.
- **Why:** each of these caused a real bug in review: focus lost, a paginator stuck hidden, `menuOpen` stuck at `false`, a refit that never retries.
- **Example:** filtered count: `filteredValue?.length ?? value.length`, not `value.length`.
- Seen in: PR 374, 375, 378, 383, 388.

## 7. Accessibility
- **Do:** include status content (such as a tag) in the accessible name. When the target control does not exist, move focus to the next control.
- **Avoid:** `aria-labelledby` that points only to the title, and focus that falls to `<body>`.
- **Why:** screen readers announce "Tab 1" instead of "Tab 1, Status"; focus on `<body>` loses the user's place.
- **Example:** `aria-labelledby="<title-id> <tag-id>"`.
- Seen in: PR 362, 375.

## 8. CHANGELOG and PR description
- **Do:** add a CHANGELOG entry for every breaking change, one bullet per consumer-visible break. Make the PR description match the final code.
- **Avoid:** duplicate entries, and a description that contradicts a later commit.
- **Why:** consumers read the CHANGELOG to see what breaks; a wrong description misleads the reviewer.
- **Example:** a changed default (sticky rows 5 to 10) gets its own bullet.
- Seen in: PR 373, 378, 383, 389, 400.

## 9. Storybook
- **Do:** show only controls that affect the story. Document the canonical stack (for tables: `px-table-selection-wrapper` around `px-table-v1`).
- **Avoid:** file-level `meta.component` and `controls.include` that expose controls to stories where they do nothing.
- **Why:** both settings apply to every story in the file, so a control can appear in stories that ignore it.
- **Example:** limit `controls.include` per story to the args that story binds.
- Seen in: PR 359, 379, 381.

## 10. Fix the root cause
- **Do:** fix the desync itself. Keep event order the same in lazy and non-lazy modes.
- **Avoid:** reordering calls so it works only when the parent handles the event synchronously.
- **Why:** a workaround breaks as soon as a parent updates state asynchronously.
- **Example:** reconcile `selectAll` between table and parent instead of reordering `selectionChange` and `eOnHeaderCheckboxToggle`.
- Seen in: PR 383.

## 11. Event propagation
- **Do:** let click events reach `document` unless there is a strong reason.
- **Avoid:** `stopPropagation` in `px-button` and `px-iconbutton`.
- **Why:** PrimeNG closes menus from a document-level outside-click handler; if the click never reaches `document`, the first menu stays open when another trigger is clicked.
- Seen in: PR 357.

## 12. Patches
- **Do:** pin the exact dependency version when a patch is needed, and name the patch after it.
- **Avoid:** a patch tied to a hashed file name (such as `generator-BE3gkZhw.mjs`) with a caret range.
- **Why:** a routine `npm install` can pull a new version where the hashed file name changed, and the install breaks.
- Seen in: PR 380.

## 13. Angular syntax
- **Do:** use `@if` and `@for` (available since Angular 18; the repo is on 19).
- **Avoid:** `*ngIf` and `*ngFor` in new code.
- **Example:** `@if (open) { … }`
- Seen in: PR 365.
