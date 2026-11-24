# Repo checks: rules the pre-check agent can verify

Status: proposal, not yet reviewed by the team reviewer. Items marked "Open" are not decided.
Source: moved on 2026-11-24 from sections 3, 4 and 9 of the pre-check agent's rules skill (`phenom-ds-rules`, written Oct 2026). The "Source" lines name documents of the phenom-ds repo, as the rules skill recorded them. They were not re-checked today.
Why this file: the guidelines in this brain say what to do. These rules also say how serious a break is and how to check it, which the pre-check agent (SHELL-742) needs.
Paths are relative to `projects/phenom-ds/` unless they start with a repo-root name. Severity: "always/never/must" = FAIL, "prefer/avoid" = WARN.

## Open
- **Inputs and outputs:** rule "Public inputs use Nullable<T>" assumes `@Input()` decorators. `guidelines/angular.md` says to use `input()` and `output()` functions. Which applies to new components? Ask the reviewer.
- **Query-backed state:** the rule below assumes `@ContentChild` and `@ViewChild`. `angular.md` does not mention signal queries.
- **Not moved:** the rules on tokens, styling, tests and docs, accessibility, security and SonarQube. The SonarQube numbers (coverage baseline, October 2026) stay with the agent, since they change often.

## 1. Component structure and public API

### OnPush change detection
- Rule: Every new or changed `@Component` sets `changeDetection: ChangeDetectionStrategy.OnPush`.
- Severity: FAIL
- Source: eslint.config.mjs (prefer-on-push-component-change-detection: error)

### Selector is kebab-case with px prefix
- Rule: New component selectors are `px-<name>` in kebab-case. eslint `component-selector` also allows `app`, `lib`, `p`, so this is checked by reading, not by lint.
- Severity: FAIL
- Source: Team decision, DEV_CONSTRAINTS.md

### No renamed inputs or outputs
- Rule: No `@Input('alias')` or `@Output('alias')` renames; lifecycle hooks only in decorated classes.
- Severity: FAIL
- Source: eslint.config.mjs (no-input-rename, no-output-rename, contextual-lifecycle)

### Public inputs use Nullable<T>
- Rule: New public `@Input()` on `px-*` is typed `Nullable<T>` from `primeng/ts-helpers`; no `| null = null` in new code. Existing legacy declarations are changed only when the requirement already touches them.
- Severity: FAIL
- Bad: `@Input() icon: string | null = null;`
- Good: `@Input() icon: Nullable<string>;`
- Source: FIX_RULES.md

### Query-backed state uses undefined
- Rule: Fields filled by `@ContentChild(ren)` or `@ViewChild(ren)` are declared `foo?: T`, not `T | null = null`; keep the `*ngIf` guard around `NgTemplateOutlet`.
- Severity: WARN
- Good: `@ContentChild('header') headerTemplate?: TemplateRef<any>;`
- Source: FIX_RULES.md

### New component file layout
- Rule: A new component folder under `src/lib/components/px-<name>/` has `px-<name>.component.ts` (template either inline or in a separate `.component.html`), `.component.scss`, `.component.spec.ts`, `.stories.ts`, `index.ts`, and is exported from `public-api.ts`. Add `.module.ts`, `.interface.ts`, `.docs.mdx`, and `stories/*.controls.ts` when the component has an NgModule, public types, a docs page, or split controls. Do not add `.args.ts` or `.arg-types.ts`: no recent component uses them.
- Severity: WARN
- Source: px-system-messages, px-table-header, px-bulk-actions-bar (file layout)

### New components are exported
- Rule: A new public component and its interfaces are exported from `public-api.ts` and the component `index.ts`.
- Severity: FAIL
- Source: build-pds-component SKILL.md, DEV_CONSTRAINTS.md

### No breaking public API change without a migration note
- Rule: Removing or renaming anything exported from `public-api.ts`, or removing/renaming a public input or output, needs a migration note in the PR or docs.
- Severity: FAIL
- Source: FIX_RULES.md, contribute-workflow.mdx

### High-care components
- Rule: Any API change to px-inputtext, px-dropdown, px-multiselect, px-checkbox, px-calendar, px-textarea, px-button, px-iconbutton, px-splitbutton, px-textbutton, px-table-v1 (and cells), px-sidebar, px-sidebar-navigation, px-breadcrumb, px-tabmenu, px-snackbar, px-modal, px-system-messages is called out.
- Severity: INFO when the ticket, plan, or requirements name the component; WARN only when the component was changed without the requirements asking for it.
- Source: DEV_CONSTRAINTS.md

### New outputs do not use the on* prefix
- Rule: A new output named `on*` is flagged (eslint `no-output-on-prefix` is warn). Existing deprecated `onClick`, `onChange`, `onDropdownClick` aliases stay allowed.
- Severity: WARN
- Source: Team decision, eslint.config.mjs

### Action-family outputs use the eOn prefix
- Rule: New generic click/change outputs on px-button, px-iconbutton, px-textbutton, px-splitbutton, px-switchbutton, px-chip-button are `eOnClick`, `eOnChange`, `eOnDropdownClick`; a renamed bare name keeps a working alias for one release. Exceptions: form controls already on `eOn*`, direct PrimeNG passthrough, semantic events (`viewClick`, `selectionChange`, `visibleChange`).
- Severity: WARN
- Source: contribute-component-structure.mdx

## 2. Scope and forbidden paths

### Generated, vendor, and credential paths
- Rule: The diff does not touch `projects/phenom-ds/documentation.json`, `dist/`, `coverage/`, `.angular/`, anything in `node_modules`, `.npmrc`, credentials, or registry config.
- Severity: FAIL
- Source: DEV_CONSTRAINTS.md, FIX_RULES.md

### Vendor PrimeNG theme
- Rule: The diff never edits `src/lib/styles/_primeng/**`; use `styles/phenom/extensions/`.
- Severity: FAIL
- Source: Team decision, FIX_RULES.md

### High-blast-radius paths
- Rule: Changes to `src/lib/styles/`, `utils/`, `directives/`, `pipes/`, `interfaces/`, `px-table-v1/` (InterceptingTableService), `px-snackbar/px-snackbar.service.ts`, `px-common/message.service.ts`, `styles/phenom/base/_uxvars.scss` are WARN unless the requirements name them.
- Severity: WARN
- Source: DEV_CONSTRAINTS.md, FIX_RULES.md

### Project and tooling files
- Rule: `package.json`, `angular.json`, lockfiles, `src/app/**`, `audits/**`, `VALIDATION_PROCESS.md`, `AUDIT_*.md`, `DESIGN_SYSTEM_AUDIT.md`, `DEV_CONSTRAINTS.md` change only when the requirements say so.
- Severity: WARN
- Source: FIX_RULES.md

### No scope creep
- Rule: Sibling `px-*` components, paths marked OUT OF SCOPE in the requirements, drive-by refactors, and formatting-only sweeps are not in the diff.
- Severity: WARN
- Source: FIX_RULES.md

## 3. Branch and commits

### Branch name
- Rule: Branch is `SHELL-<number>_<short-name>`, short name lowercase with hyphens, and is not `main`. This replaces the other branch schemes in the docs.
- Severity: WARN
- Good: `SHELL-522_button-focus-ring`
- Source: Team decision

### Base branch
- Rule: Branch is kept rebased on `main`. When `git merge-base HEAD origin/main` is not `origin/main`'s tip, intersect `git diff HEAD...origin/main --name-only` with the files changed on this branch. If the intersection is non-empty, list the overlapping files and the main-side commits that touched them, and recommend a rebase before merge.
- Severity: WARN when the intersection is non-empty; INFO when empty (behind main but no overlap with the branch's diff).
- Source: Team decision, contribute-workflow.mdx

### Conventional commit with Jira key
- Rule: Each commit is `type(scope): summary (SHELL-123)` with a type from: build, chore, ci, docs, style, refactor, perf, test, fix, feat, revert, version; the literal Jira key appears (an audit id like REM-003 does not count); header at most 200 characters, body lines at most 500.
- Severity: WARN
- Good: `fix(px-button): restore focus ring (SHELL-522)`
- Source: Team decision, commitlint.config.js, build-pds-component SKILL.md

### Branch and commit keys match
- Rule: The Jira key in the branch name equals the key in every commit.
- Severity: WARN
- Source: build-pds-component SKILL.md
