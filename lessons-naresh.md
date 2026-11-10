# Review lessons: Naresh

Status: draft, not yet approved.
Source: 15 review comments in 9 merged PRs, 2024-12-04 to 2025-11-07.
Lessons 2, 3 and 4 come from one long comment in PR 189 that looks like an automated review. Treat them as suggestions, not confirmed team rules.

## 1. Use existing tokens and variables
Do not hard-code colors, including inside SVG. Use predefined variables for shadows and white. Map an existing color instead of inventing a new one.
Seen in: PR 13, 39, 189.

## 2. Every new component has a spec
A new component has a `.spec.ts` file.
Seen in: PR 189.

## 3. Accessibility for decorative and status elements
Add `aria-label` or `aria-hidden="true"` to a decorative component. Add `role="status"` when it conveys information.
Seen in: PR 189.

## 4. No unused imports
Remove imports in the module file that the component does not need.
Seen in: PR 189.

## 5. Explain removal of existing behaviour
Explain why existing behaviour (such as a tooltip) is removed, and how it affects accessibility and usability.
Seen in: PR 118.

## 6. Check dependent components
Test dependent components before changing broad styles, such as `inputnumber`.
Seen in: PR 182.

## 7. No bindings without styles
Do not leave a template binding or class that has no CSS.
Seen in: PR 171.

## 8. Run and check
Run `npm run watch:lib` and check the console. Check for Angular 19 errors in `encapsulation` and `changeDetection` settings.
Seen in: PR 148, 154.

## 9. Icons
Use FontAwesome SVG icons.
Seen in: PR 39.

## 10. Sizes
Check that the sizes in the design (`extra-small`, `tiny`) exist in this version of the component.
Seen in: PR 39.
