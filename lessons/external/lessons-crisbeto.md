# Lessons from an external reviewer (angular/components, crisbeto)

Status: draft, not yet approved.
Source: 53 review comments, 2026-05-13 to 2026-11-06, about 35 PRs in the public repo angular/components.
Format: Do / Avoid / Why / Example. Examples are short illustrations written from the review comment, not copied code.
Fit: these come from Angular Material, a public library. Each lesson must be checked against phenom-ds and its Angular version before it becomes a rule. Lessons marked "context only" probably do not apply.

## 1. Don't add an API for what styling already does
- **Do:** let users style through a panel class or the host element.
- **Avoid:** a new input or option that only sets a margin or a style.
- **Why:** users can already get the same result, and each public option must be maintained.
- **Example:** `.my-panel-class mat-bottom-sheet-container { … }` instead of a new config option.
- Seen in: PR 33248, 34029.

## 2. Combine duplicated code
- **Do:** merge near-identical loops or blocks, and group repeated wrappers (such as several `untracked`) into one.
- **Avoid:** copying a block where only one condition differs.
- Seen in: PR 33242, 33362.

## 3. Don't validate internal calls
- **Do:** skip checks for functions that are only called internally with fixed values.
- **Why:** the check adds code that can never fail.
- Seen in: PR 33410.

## 4. Keep single-use helpers in-line
- **Do:** write the check where it is used.
- **Avoid:** exposing a new public method for one caller.
- Seen in: PR 33846.

## 5. Stricter behaviour needs an opt-out
- **Do:** add a flag (for example `ignoreInert`, like the existing `ignoreVisibility`) when a new check can change results for existing consumers.
- **Why:** the stricter check broke some internal apps.
- Seen in: PR 33846.

## 6. Don't build detection the framework already gives
- **Do:** let the framework report errors.
- **Avoid:** a custom warning layer for a rare case.
- **Why:** it must be maintained, and false positives are possible. The reviewer saw little value.
- Seen in: PR 33908.

## 7. Set styles through framework bindings
- **Do:** bind the style in the template.
- **Avoid:** setting it directly on the DOM element.
- **Example:** `[style.display]="'none'"`.
- Seen in: PR 33947.

## 8. Don't trigger change detection synchronously to make something work
- **Why:** the reviewer called it "smelly" and had not needed it anywhere else.
- Seen in: PR 33881.

## 9. Avoid timeouts to wait for focus
- **Do:** if a timeout is unavoidable, say why in a code comment.
- **Why:** the reviewer disliked the timeout but saw no better way to wait for focus to move into a popup.
- Seen in: PR 33518.

## 10. Docs and examples use current patterns
- **Do:** use signal forms in examples and guides.
- **Avoid:** the old forms modules and `standalone: true`.
- **Why:** the reviewer asked to promote the current pattern in all examples.
- Seen in: PR 33718, 33886.

## 11. Use components for their purpose
- **Do:** keep interactive components for interactive content.
- **Avoid:** `mat-option` for a loading row.
- Seen in: PR 33720.

## 12. Remove what has no effect
- **Do:** remove CSS, tests and attributes that do nothing, and check that a style really applies.
- **Why:** the reviewer pasted the styles and saw them overridden.
- Seen in: PR 33698, 33570, 34029, 34082.

## 13. Weigh changes that break density or screenshots
- **Do:** say in the PR when a change affects density modes or many screenshot tests.
- **Why:** hiding or resizing a touch target can break the density system, and a dialog padding change breaks almost every screenshot with a dialog.
- Seen in: PR 33570, 33676.

## 14. Visibility, `const`, naming
- **Do:** make members used only inside the component `protected`. Use `const` when not reassigned. Follow existing names exactly (`timeZone`, `setTimeZone`). Throw a clear error when two options conflict.
- Seen in: PR 33693, 33564, 33579.

## 15. Don't support inaccessible patterns
- **Avoid:** inputs or textareas inside a select.
- **Why:** it is not a valid accessibility pattern.
- Seen in: PR 33971.

## 16. Answer "why" in the PR
- **Do:** put the context for a test or code change in the PR description.
- Seen in: PR 33317.

## Context only (Angular Material internal)
- The CDK must not use Material concepts. (PR 33388)
- Cleanups can break internal apps whose tests stub things. (PR 33899, 33907)
