# Accessibility guidelines

Status: approved by the team reviewer. Open items are marked in the text.
Target: WCAG 2.x level AA, and the code must pass AXE checks (from the official Angular rules file, see `angular.md`).
Sources are marked on each rule:
- **Team** = a review comment from our own PRs (`lessons/by-reviewer/`).
- **External** = an outside library (`lessons/external/`, spartan skill). Needs checking against our code.
- **WCAG** = general WCAG AA requirement, not taken from our reviews.
Format: Do / Avoid / Why / Example.

## 1. Status content is part of the accessible name (Team)
- **Do:** include status content (such as a tag) in the accessible name of the control.
- **Avoid:** `aria-labelledby` that points only to the title.
- **Why:** screen readers announce "Tab 1" instead of "Tab 1, Status".
- **Example:** `aria-labelledby="<title-id> <tag-id>"`.
- Seen in: PR 362.

## 2. Focus never falls to `<body>` (Team)
- **Do:** when the target control is missing, disabled or hidden, move focus to the next control.
- **Avoid:** calling `focus()` on an element that may not exist.
- **Why:** focus on `<body>` loses the user's place.
- Seen in: PR 375.

## 3. Decorative and status elements (Team, suggestion)
- **Do:** give a decorative component `aria-hidden="true"` or an `aria-label`. Give an element that conveys information `role="status"`.
- **Why:** reviewers also asked for the reason behind every `aria-hidden`. State it in the PR.
- Seen in: PR 189 (suggestion from an automated-looking review), PR 302.

## 4. Overlays have a title (External)
- **Do:** give a dialog, sheet or alert dialog a title. If the design hides it, keep it in the page and hide it visually only.
- **Why:** the title is the accessible name of the overlay.
- **Example:** `class="sr-only"` on the title element.
- Source: spartan skill, `rules/composition.md`.

## 5. Do not support invalid patterns (External)
- **Avoid:** an input or textarea inside a select.
- **Why:** it is not a valid accessibility pattern.
- Seen in: angular/components PR 33971.

## 6. Do not claim what the code does not do (Team)
- **Do:** in docs and stories, describe only keyboard and screen-reader behaviour the code has. Write known gaps as "Known gap: ...".

## 7. Keyboard (WCAG)
- **Do:** every interactive element works with the keyboard alone, in a logical order, and shows a visible focus.
- **Avoid:** click handlers on `div` or `span`.
- **Example:** use `<button>`, not `<div (click)>`.

## 8. Names and labels (WCAG)
- **Do:** every control, icon button and form field has an accessible name (visible label, or `aria-label` for icon-only).
- **Avoid:** placeholder text as the only label.

## 9. Color and contrast (WCAG)
- **Do:** text contrast at least 4.5:1 (3:1 for large text and UI parts). Do not use color as the only signal.
- **Why:** AXE reports contrast, but only on rendered pages. Use design tokens that already meet it.

## 10. What cannot be checked by reading code
- Keyboard flow, focus order and screen-reader output need a live check in Storybook.
- A long text, and where focus goes when its target is missing, also need a live check.
- Never report accessibility as passed from reading code alone.
