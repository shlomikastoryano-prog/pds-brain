# Review lessons: Mayank

Status: draft, not yet approved.
Source: 63 review comments in 34 merged PRs, 2025-01-10 to 2026-09-08.
Format: Do / Avoid / Why / Example. Examples are short illustrations written from the review comment, not copied code. "Why" is stated only where the review gave a reason; otherwise it is marked.

## 1. No function calls from templates
- **Do:** compute the value in the component (a field, `computed` or a pre-built map) and bind it. Simple conditions can stay in the template.
- **Avoid:** `{{ getLabel(item) }}` or `[class]="getClass(item)"` in the template.
- **Why:** reason not given in the comments (14 comments, no explanation). A common reason is that the function runs on every change detection. To be verified with the reviewer.
- **Example:** `readonly label = computed(() => format(this.value()));` then `{{ label() }}`.
- **Possible lint rule:** forbid call expressions in templates. Seen 14 times, so a good candidate.
- Seen in: PR 91, 300, 301.

## 2. No hard-coded English text
- **Do:** take tooltips, labels and statuses ("Unread") as inputs or from translations.
- **Avoid:** English strings inside the component.
- **Why:** the product is multi-language.
- **Example:** `@Input() unreadLabel` instead of the literal `'Unread'`.
- Seen in: PR 162, 300, 317, 333, 334.

## 3. Keep backward compatibility
- **Do:** keep events, interfaces and public API as they are. A breaking change goes only in a major version with a clear CHANGELOG.
- **Avoid:** removing an event (for example `selectionChange`) or changing the type that consumers handle (`IActionEvent`).
- **Why:** other teams use these components and handle the existing events.
- **Example:** deprecate the old event and add the new one next to it, then remove it in the next major.
- Seen in: PR 286, 290, 304.

## 4. Explain every change
- **Do:** state in the PR what problem each change solves, including small ones like `aria-hidden`.
- **Avoid:** removing or adding code with no reason in the description or a code comment.
- **Why:** reviewers asked "what problem are we solving" and "why are we removing this" on six PRs.
- **Example:** one line in the PR description per non-obvious change.
- Seen in: PR 284, 286, 296, 302, 348.

## 5. No `ng-deep` and no `!important`
- **Do:** move the style rules to global styles.
- **Avoid:** `::ng-deep` and `!important`.
- **Why:** `ng-deep` is deprecated.
- **Possible lint rule:** a stylelint rule against `!important`.
- Seen in: PR 182, 276.

## 6. `@for` with a unique track
- **Do:** use `@for` with `track` on a unique id.
- **Avoid:** tracking by a label that can repeat.
- **Why:** the component breaks if two labels are the same.
- **Example:** `@for (item of items; track item.id)`.
- Seen in: PR 276.

## 7. Use rem
- **Do:** use `rem` units.
- **Avoid:** `px` for sizes in styles.
- **Why:** reason not given in the comment (asked as a question).
- Seen in: PR 17.

## 8. Do not bump the version manually
- **Do:** leave the version in `package.json` as is.
- **Why:** CI does it.
- Seen in: PR 243.

## 9. Keep the component API small
- **Do:** keep internal props internal. Let a parent pass one size to its children. Make a value an input instead of hard-coding it.
- **Avoid:** a public option on each child (for example `showMenu` on a group item, or size per control).
- **Why:** users do not configure internal props, and each public prop must be maintained.
- **Example:** the table header takes one `size` and passes it down.
- Seen in: PR 245, 276, 326, 337.

## 10. Reuse what exists
- **Do:** use `pxtooltip`, icons from `FontAwesomeModule`, and compose from `px-button`.
- **Avoid:** the PrimeNG tooltip, a parallel component for a variant of an existing one.
- **Why:** one implementation to maintain, consistent behaviour.
- Seen in: PR 41, 317, 336.

## 11. Storybook
- **Do:** group inputs and outputs in a table. Add the Figma link and a description in `parameters`.
- Seen in: PR 46.

## 12. Follow the ticket
- **Do:** check the requirements in the Jira ticket before and after the change.
- **Avoid:** adding or removing UI the ticket does not mention. If it was added on purpose, link the ticket that requires it.
- **Why:** reviewers pointed to the ticket twice to explain what was required.
- Seen in: PR 118, 264.

## 13. Check other teams before removing
- **Do:** ask the teams that use an icon or an API before removing it.
- **Why:** the settings icon was used by multiple teams.
- Seen in: PR 339.

## 14. Event loops and popovers
- **Do:** check that a handler does not call itself through a chain (view group → `viewClick` → `onViewClick` → view group). Check how a popover is hidden when `useHoverPopover` is true.
- **Why:** a loop was suspected in the review.
- Seen in: PR 250, 326.
