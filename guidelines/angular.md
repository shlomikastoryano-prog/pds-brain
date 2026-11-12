# Angular guidelines

Status: draft, not yet approved.
Source: the Angular team's own rules file for AI tools (https://angular.dev/assets/context/best-practices.md), downloaded 2026-11-12 and adapted to our version.
Our version: Angular 19.2 (`@angular/core ^19.2.14`), PrimeNG 17, TypeScript 5.8. Checked in package.json.
Rule: use the "Apply now" list. Do not use the "Not for our version" list.

## Apply now (Angular 19)
- **TypeScript:** use strict typing. Prefer inference when the type is obvious. Avoid `any`, use `unknown` when the type is uncertain.
- **Components:** keep them small, with a single responsibility. Use `input()` and `output()` functions, `model()` for two-way binding, `computed()` for derived state, `linkedSignal()` for state derived from several sources.
- **State:** use signals for local state. Keep transformations pure. Use `update` or `set`, never `mutate`.
- **Templates:** keep them simple, no complex logic. Use `@if`, `@for`, `@switch` instead of `*ngIf`, `*ngFor`, `*ngSwitch`. Use the async pipe for observables.
- **Bindings:** use `class` and `style` bindings instead of `ngClass` and `ngStyle`. Import only the directives and pipes the template uses, not `CommonModule`.
- **Host bindings:** use the `host` object of the decorator, not `@HostBinding` or `@HostListener`.
- **Services:** one responsibility each. Use `inject()` instead of constructor injection.
- **Forms:** prefer reactive forms over template-driven ones.
- **Images:** use `NgOptimizedImage` for static images (not for inline base64).
- **Files:** with external templates or styles, use paths relative to the component TS file.
- **Accessibility:** must pass all AXE checks and follow WCAG AA, including focus management, color contrast and ARIA attributes.
- **Lazy loading:** lazy-load feature routes.

## Not for our version (do not apply yet)
- "Do NOT set `OnPush` explicitly": `OnPush` is the default only in Angular 22+. On 19 keep it explicit.
- "Prefer Signal Forms (`@angular/forms/signals`)": stable only in Angular 22+.
- "Prefer the `@Service` decorator": Angular 22+.
- "Do NOT set `standalone: true`": the source says it is the default in Angular 20+. To be verified whether this also holds on 19.2 before adopting.

## Where our code differs today (counts in `projects/phenom-ds/src`, checked 2026-11-12)
- `*ngIf` / `*ngFor`: 117 files.
- `@HostListener` / `@HostBinding`: 22 files.
- `standalone: true`: 44 files.
- Explicit `OnPush`: 151 files.
- These are existing code. Apply the rules to new and changed code, do not migrate everything in one change.
