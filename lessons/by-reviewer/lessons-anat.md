# Review lessons: Anat

Status: draft, not yet approved.
Source: 30 review comments in 17 merged PRs, 2026-09-14 to 2026-11-05. Long comments were read only in part.

## 1. Use tokens, not hard-coded values
Use shadow and color tokens instead of hard-coded color values.
Seen in: PR 355.

## 2. Clean up resources on destroy
Cancel `requestAnimationFrame` in `ngOnDestroy`. Do not keep an app-wide listener such as `@HostListener('document:focusin')` attached while the component is not visible.
Seen in: PR 355, 382.

## 3. Remove unnecessary code
Remove unneeded `detectChanges`, unused functions, unreachable branches and redundant methods.
Seen in: PR 355, 389, 400.

## 4. Keep layout stable
Give bars a `min-width`. Put captions in a container with a max width and an ellipsis, so they do not push neighbouring controls.
Seen in: PR 355, 365.

## 5. Add and strengthen tests
Add tests to every enhancement. A guard test must start from the state the guard protects, not from an empty state.
Seen in: PR 365, 389.

## 6. Check state edge cases
Check: no inline actions, an async parent (store, `setTimeout`, OnPush with async pipe), an internal filter with zero matches, `clear()` after a filter, a fast menu reopen, a fit skipped while a menu is open.
Seen in: PR 374, 375, 378, 383, 388.

## 7. Accessibility
Include status content (such as a tag) in the accessible name. Never let focus fall to `<body>`: fall back to the next control.
Seen in: PR 362, 375.

## 8. CHANGELOG and PR description
Add a CHANGELOG entry for every breaking change, one bullet per consumer-visible break, without duplicates. The PR description must match the code.
Seen in: PR 373, 378, 383, 389, 400.

## 9. Storybook
Do not show controls that do nothing in a story. `meta.component` and `controls.include` apply to every story in the file. Document the canonical stack in the docs.
Seen in: PR 359, 379, 381.

## 10. Fix the root cause
Do not work around a state desync. Keep event order consistent between modes (lazy and non-lazy).
Seen in: PR 383.

## 11. Event propagation
`stopPropagation` in `px-button` and `px-iconbutton` stops PrimeNG menus from closing on an outside click.
Seen in: PR 357.

## 12. Patches
A patch tied to a hashed file name breaks on a dependency update.
Seen in: PR 380.

## 13. Angular syntax
`@if` and `@for` are available since Angular 18.
Seen in: PR 365.
