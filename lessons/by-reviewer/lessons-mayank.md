# Review lessons: Mayank

Status: draft, not yet approved.
Source: 63 review comments in 34 merged PRs, 2025-01-10 to 2026-09-08.

## 1. No function calls from templates
Do not call methods or functions from the template. Compute the value in the component and bind it.
Seen in: PR 91, 300, 301 (14 comments).

## 2. No hard-coded English text
Take translatable text (tooltips, labels, "Unread") as inputs or from translations.
Seen in: PR 162, 300, 317, 333, 334.

## 3. Keep backward compatibility
Do not change events, interfaces or an existing API in a breaking way. Such a change is allowed only in a major version, with a clear CHANGELOG.
Seen in: PR 286, 290, 304.

## 4. Explain every change
State what problem a change solves. Reviewers ask why something is removed or added, including `aria-hidden`.
Seen in: PR 284, 286, 296, 302, 348.

## 5. No `ng-deep` and no `!important`
Move styles to global instead of using `ng-deep`. Do not use `!important`.
Seen in: PR 182, 276.

## 6. `@for` with a unique track
Use the Angular 19 `@for` with a unique `track`. Never track by a label that can repeat.
Seen in: PR 276.

## 7. Use rem
Use `rem` instead of `px`.
Seen in: PR 17.

## 8. Do not bump the version manually
Do not edit the version in `package.json`. CI does it.
Seen in: PR 243.

## 9. Keep the component API small
Props that users do not configure stay internal. A parent component passes the size to its children. Make a value an input instead of hard-coding it.
Seen in: PR 245, 276, 326, 337.

## 10. Reuse what exists
Use `pxtooltip` and not the PrimeNG tooltip. Use icons from `FontAwesomeModule`. Compose from `px-button` instead of creating a parallel component.
Seen in: PR 41, 317, 336.

## 11. Storybook
Group inputs and outputs in a table. Add the Figma link and a description in the parameters.
Seen in: PR 46.

## 12. Follow the ticket
Check the requirements in the Jira ticket before the change.
Seen in: PR 118, 264.

## 13. Check other teams before removing
Check with the teams that use an icon or an API before removing it.
Seen in: PR 339.

## 14. Event loops and popovers
Check that an event handler does not call itself in a loop, and how a popover is hidden when `useHoverPopover` is true.
Seen in: PR 250, 326.
