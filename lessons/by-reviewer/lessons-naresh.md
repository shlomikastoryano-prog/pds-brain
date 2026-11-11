# Review lessons: Naresh

Status: draft, not yet approved.
Source: 15 review comments in 9 merged PRs, 2024-12-04 to 2025-11-07.
Lessons 2, 3 and 4 come from one long comment in PR 189 that looks like an automated review. Treat them as suggestions, not confirmed team rules.
Format: Do / Avoid / Why / Example. Examples are short illustrations written from the review comment, not copied code. "Why" is stated only where the review gave a reason.

## 1. Use existing tokens and variables
- **Do:** use predefined variables for shadows and white. Map an existing color to the component variable.
- **Avoid:** hard-coded colors, including inside SVG, and inventing a new color.
- **Example:** map `phnmSecondaryColor` to `checkboxActiveBorderColor` instead of a new value.
- Seen in: PR 13, 39, 189.

## 2. Every new component has a spec (suggestion)
- **Do:** add a `.spec.ts` file with every new component.
- Seen in: PR 189.

## 3. Accessibility for decorative and status elements (suggestion)
- **Do:** add `aria-label` or `aria-hidden="true"` to a decorative component. Add `role="status"` when it conveys information.
- Seen in: PR 189.

## 4. No unused imports (suggestion)
- **Do:** remove imports in the module file that the component does not need.
- Seen in: PR 189.

## 5. Explain removal of existing behaviour
- **Do:** explain why existing behaviour (for example a tooltip) is removed, and how it affects accessibility and usability.
- **Avoid:** removing it silently.
- **Why:** the existing tooltip showed regardless of ellipsis and the label has a minimum width of 160px, so the reviewer asked for the reason.
- Seen in: PR 118.

## 6. Check dependent components
- **Do:** test the components that depend on a broad style (such as `inputnumber`) before changing it.
- **Why:** dependent components may stop working.
- Seen in: PR 182.

## 7. No bindings without styles
- **Do:** remove a template binding or class that has no CSS, or add the CSS.
- **Example:** `[style.width]="contentWidth"` on `px-accordion-tab-content-wrapper` with no matching CSS.
- Seen in: PR 171.

## 8. Run and check
- **Do:** run `npm run watch:lib` and check the console. Check the `encapsulation` and `changeDetection` settings for Angular 19 errors.
- **Example:** error seen: "encapsulation must be a member of ViewEncapsulation enum".
- Seen in: PR 148, 154.

## 9. Icons
- **Do:** use FontAwesome SVG icons.
- Seen in: PR 39.

## 10. Sizes
- **Do:** check that the sizes in the design (`extra-small`, `tiny`) exist in this version of the component.
- **Example:** the text button did not have `extra-small` or `tiny`.
- Seen in: PR 39.
