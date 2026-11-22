# Reviewer draft agent (prompt)

Status: shared by the team reviewer on 2026-11-19, as is. Not adapted to phenom-ds yet and not tested by us. The agents that write code do not read this file.
Purpose: drafts a thorough review of one Bitbucket PR for the reviewer. Drafts only: it never posts, approves or comments by itself.
Where it fits: this is a reviewer-side agent. Its checks overlap with `guidelines/definition-of-done.md` (SHELL-742). Open: whether it reads the brain lessons, and where agents live (SHELL-747, option B puts them in this `agents/` folder).
Known caveats: generic for any repo, builds the PR locally (can take long), uses the Atlassian MCP instead of the Bitbucket token.

## Prompt (copy from here)

## Input
PR = "<bitbucket PR link, e.g. https://bitbucket.org/<workspace>/<repo>/pull-requests/<id>>"

Draft a thorough, elaborate review for this single Bitbucket PR. Verify that it builds locally, does not introduce breaking changes, has enough function/branch coverage on the code it changes, reuses existing shared code instead of duplicating it, and (in Angular repos) uses the latest syntax supported by the repo's Angular version in the code it touches.
Drafts only: never post, approve, comment, resolve, or create tasks in Bitbucket or Jira. Never push or commit.
Be economical when GATHERING context (metadata before content, local git before API diffs, never fetch the same thing twice, never print full build or test logs), but be complete and detailed in the REVIEW OUTPUT.

Tools: Atlassian MCP (Bitbucket + Jira operations via executeRead), plus local git and shell in the local repos root.
Call getAccessibleAtlassianResources once and reuse the cloudId. Call atlassianUserInfo once to get MY accountId ("me" below).

## Step 1 — Triage (do it yourself, no diffs in context)
1. Parse workspace, repo slug, and PR id from the PR link. Call getBitbucketRepoPullRequest once and keep only: title, author (display name → DEVELOPER, first name for the comment), state, source/destination branch, source commit hash, updated_on, comment_count, task_count, participants (role, approved, participated_on).
   If the PR isn't OPEN, tell me its state and stop.
   Ticket key: the first [A-Z]+-\d+ in the title, then the branch, then the description. If there's none, say so and review without a ticket.
2. My last review = the latest participated_on/approval of mine in participants. If it's missing, the mode is FULL.
3. In the local repo (<repos root>/<repo>): `git fetch -q origin <src> <dst>`, then:
   - `git diff --shortstat --name-only origin/<dst>...origin/<src>`   (FULL scope)
   - if I reviewed it before: base = `git rev-list -1 --before=<my last review> origin/<src>`, and `git diff --shortstat --name-only <base>..origin/<src>`
   If the repo isn't cloned, clone it into the repos root first; if you can't, tell me.
4. Mode:
   - NOTHING NEW: I reviewed it, and there are no commits and no new comments since then. Tell me, list my still-open comments/tasks, and stop.
   - DELTA: I reviewed it, and there are new commits since. The review scope is <base>..src.
   - FULL: I've never reviewed it.
5. Build and coverage commands, from the files at the repo root:
   - package.json → install with the lockfile's tool (`npm ci` / `pnpm i --frozen-lockfile` / `yarn install --immutable`), then `<tool> run build`. If there's no build script, use `typecheck` or `tsc --noEmit`.
     Coverage: `npx jest --coverage --coverageReporters=json-summary --collectCoverageFrom=<changed src files> --findRelatedTests <changed src files>` (or the vitest/karma equivalent the repo uses).
   - pom.xml → `mvn -q -B -DskipTests package`; coverage via `mvn -q -B test jacoco:report` (read target/site/jacoco/jacoco.csv)
   - build.gradle(.kts) → `./gradlew build -x test -q`; coverage via `./gradlew test jacocoTestReport -q`
   - pyproject.toml/setup.py → `python -m build`; coverage via `pytest -q --cov=<pkg> --cov-branch --cov-report=json`
   - go.mod → `go build ./...`; coverage via `go test -coverprofile=c.out ./<changed pkgs>` (functions only, via `go tool cover -func`)
   - *.csproj/sln → `dotnet build -nologo -v q`; coverage via `dotnet test --collect:"XPlat Code Coverage"`
   - If the repo documents its own build/test commands (README, Makefile, Jenkinsfile, bitbucket-pipelines.yml), use those instead.
   Coverage threshold: read the repo's own config (jest coverageThreshold, karma/jacoco rules, .coveragerc fail_under, Jenkinsfile per-file/branch gates). If there is none, use 80% functions AND 80% branches.
6. Angular version (only if package.json depends on @angular/core):
   ANGULAR_VERSION = the exact installed version from `node -p "require('@angular/core/package.json').version"` (after install), or the version range in package.json if it isn't installed.
   Also note (grep -l, counts only) whether the repo already uses: `@if`/`@for`, `input(`/`output(`/`model(`, `inject(`, `standalone`, `takeUntilDestroyed`. This is the "precedent".
   Note any angular-eslint rules that enforce modern syntax (prefer-control-flow, prefer-signals, prefer-standalone, prefer-inject).
7. Shared folders (once): `find . -type d \( -name shared -o -name common -o -name 'util*' -o -name helpers -o -name core -o -name lib -o -name libs \) -not -path '*/node_modules/*' -not -path '*/dist/*' | head -30` → SHARED_DIRS.
8. Breaking-change risk flag (from file paths only): set BC_RISK=yes if any changed path matches
   index.(ts|js)|public|api/|exports|*.d.ts|openapi|swagger|*.proto|graphql|schema|migration|events?/|contracts?/|dto|config|env|package.json|pom.xml|build.gradle|CHANGELOG
9. Model, decided from the review scope:
   - haiku: under 50 changed lines AND only docs/config/test/style/i18n files AND BC_RISK=no.
   - opus: over 600 lines, OR a path matching migration|schema|auth|permission|security|payment|billing|lock|queue|worker|concurren|openapi|proto|contract, OR over 15 comments plus open tasks.
   - sonnet: everything else (including BC_RISK=yes when it isn't already opus).
10. Print one line: PR | repo | ticket | author | mode | lines | BC_RISK | Angular ver | model | build cmd | coverage threshold | reason. Continue without waiting.

## Step 2 — Review (one subagent)
Launch ONE general-purpose subagent with the model from Step 1.
Give it: the PR link, workspace, repo, prId, ticket key, the developer's first name, mode, BC_RISK, the local repo path, the diff range (origin/<dst>...origin/<src> or <base>..origin/<src>), the build command, the coverage command and threshold, ANGULAR_VERSION + precedent + lint rules (if Angular), SHARED_DIRS, the repos root path, my accountId, the cloudId, and this brief:

---
Review Bitbucket PR <link> for Jira <TICKET>, mode <FULL|DELTA>. Write a thorough, elaborate review: cover every issue you find, not only the main ones. Verify that it builds, check for breaking changes, check function/branch coverage of the changed code, check reuse of shared code, and (if Angular) check for modern Angular syntax in the touched code.
Drafts only, never write to Bitbucket or Jira, never commit or push. Gather context economically, but write the output in full detail.

A. Build check (do this first):
   1. `git worktree add -f /tmp/pr-<repo>-<id> origin/<src>` and run everything below inside that folder.
   2. Skip the build only if every changed file is documentation (*.md, docs/). In that case, report "Build: skipped (docs only)".
   3. Run: `<build cmd> > /tmp/pr-<repo>-<id>.log 2>&1; echo EXIT=$?`  (timeout 15 min). Never print the full log.
   4. If EXIT≠0: read only `grep -iE "error|failed" <log> | head -40` (or `tail -40` if grep finds nothing).
      Then check whether the failure is pre-existing: build origin/<dst> in a second worktree the same way.
      - PR fails, target passes → [Blocker] "Build broken by this PR", with the key error lines and the file:line they point to.
      - Both fail → "Build: pre-existing failure on <dst>", as a note (not a blocker for this PR).

A2. Coverage check (only if the build passed and the PR changes non-test source files):
   1. Run the coverage command scoped to the changed source files, with output to a log file. Read ONLY the summary for the changed files, never the full report.
   2. For each changed source file, record function % and branch %. Ignore line/statement coverage.
   3. IGNORE global/project coverage completely: the Jenkins overall coverage %, coverage deltas for the whole project, and a failed global coverage gate. Global coverage is deferred and must NOT appear in the draft.
   4. Insufficient = any changed file with function % or branch % below the threshold. For those files only, find the specific uncovered functions and branches inside the changed hunks, so the comment can name them.
   5. If coverage can't run (no test setup, tests fail for reasons unrelated to the PR, missing tooling), report "Coverage: not measured — <reason>" and don't raise it in the comment.
   6. Clean up: `git worktree remove --force` for every worktree you created, and delete logs and coverage outputs.

B. Gather context:
   1. Jira <TICKET> (getJiraIssue, compact view): summary, description, acceptance criteria, and the last ~5 comments. Parent/epic: summary line only.
      Note whether the ticket explicitly asks for, or accepts, a breaking change.
   2. Diff: run `git diff <range>` in the local repo, one file at a time. Review EVERY changed file except lockfiles, generated files, and snapshots.
   3. Previous comments: listBitbucketRepoPullRequestComments (pagelen=100) and listBitbucketRepoPullRequestTasks.
      For each of MY earlier comments and tasks, mark it addressed / not addressed / resolved without a change. Skip deleted comments and bot comments.
      Also read other reviewers' open comments, so you don't duplicate them (reference them instead).
      Ignore earlier comments (mine or a bot's/Jenkins') about global coverage.
   4. Read the surrounding code wherever you need it to judge a change correctly (callers, the full function, related tests).

C. Breaking-change check (always; go deeper if BC_RISK=yes). Look for:
   - API/library surface: removed or renamed exports, functions, classes, or endpoints; changed signatures, parameter order, return types, or thrown errors; optional → required; narrowed types or enums.
   - Behaviour: changed defaults, changed semantics for the same input, changed ordering/pagination, error codes, timeouts, side effects.
   - Data: DB migrations that drop/rename/retype columns or add NOT NULL without a default; non-backward-compatible serialization; changed event/message payloads; changed cache keys.
   - Contracts: OpenAPI/GraphQL/proto field removals, renames, or type changes; changed status codes; new required headers or auth requirements.
   - Config/runtime: renamed or removed env vars, config keys, or feature flags; changed CLI args.
   - Dependencies: major-version bumps, changed peerDependencies, dropped Node/Java/Python version support.
   - For a library: is the version bump consistent with semver, and does the CHANGELOG mention the change?
   For every suspected break, find who's affected: `git grep -l "<symbol>"` in this repo, then
   `grep -rl --include=*.{ts,js,java,py,go,cs} "<symbol>" <repos root> --exclude-dir={node_modules,dist,build,target,.git} | head -20`.
   Report the count and the repo names. Callers outside the repos root are "unknown external"; never assume they're safe.

D. Full review checklist (go through every item for every changed file):
   - Ticket fit: is every acceptance criterion met? Anything missing, partially done, or out of scope?
   - Correctness & possible bugs: edge cases, null/undefined/empty inputs, boundaries and off-by-one errors, async/await mistakes, race conditions, state handling, error paths, wrong assumptions about data.
   - Error handling & resilience: swallowed errors, generic catches, missing retries/timeouts, unclear error messages, missing or excessive logging, leaking sensitive data into logs.
   - Security: input validation, injection, authz checks, secrets in code, unsafe deserialization, insecure defaults.
   - Performance: N+1 queries, unnecessary loops or re-renders, missing memoization/caching, unbounded queries or lists, missing pagination/indexes, heavy work on hot paths, memory leaks.
   - Old/redundant code: dead code, leftover debug code, commented-out blocks, unused imports/vars/flags, code this PR made obsolete but didn't remove. (Duplication and reuse are covered in section F.)
   - Best practices & design: repo conventions, separation of concerns, function size and complexity, naming, magic numbers, typing strictness (any/unknown/casts), immutability, SOLID/DRY where relevant, consistency with surrounding code.
   - Tests: test QUALITY for the new behaviour (meaningful assertions, edge cases, no brittle mocks), and existing tests updated where behaviour changed.
     Raise coverage ONLY when A2 found function or branch coverage below the threshold on changed files. In that case, name the uncovered functions/branches and propose the specific test cases that would cover them.
     Never mention global/Jenkins coverage.
   - Documentation: README, docstrings/JSDoc, API docs, CHANGELOG, migration notes, comments on non-obvious logic, outdated comments left behind.
   - Readability & maintainability: confusing logic, nesting depth, unclear names, places where a small refactor would help.

E. Modern Angular syntax (only if the repo uses Angular; skip otherwise):
   Scope — STRICT: only lines added or modified in this PR's diff range, and new files. Never suggest changing untouched existing code, even in the same file or template.
   "Latest" = the repo's ANGULAR_VERSION. Suggest a feature only if it's STABLE in that version, or the repo already uses it (precedent). Never suggest features newer than ANGULAR_VERSION, and never experimental ones.
   If unsure whether a feature is stable in that exact version, check node_modules/@angular/core (its exports/typings) or the CHANGELOG in node_modules rather than guessing.
   Reference (minimum major version where the feature is stable):
   - v14+: `inject()` instead of constructor injection; typed reactive forms (no `UntypedFormGroup`/`any` in new forms).
   - v15+: standalone components/directives/pipes; functional guards/resolvers (`CanActivateFn`, `ResolveFn`); functional interceptors (`withInterceptors`); `hostDirectives`; `NgOptimizedImage` (`ngSrc`).
   - v16+: `takeUntilDestroyed()` / `DestroyRef` instead of manual `Subject` + `ngOnDestroy` unsubscribe; required inputs (`@Input({ required: true })`); input transforms (`booleanAttribute`, `numberAttribute`); `withComponentInputBinding()` for route params; self-closing tags for components.
   - v17+: `signal()` / `computed()` for local state instead of BehaviorSubject/plain mutable fields where reactive.
   - v18+: built-in control flow `@if` / `@for` (with `track`) / `@switch` instead of `*ngIf` / `*ngFor` / `*ngSwitch`; `@defer` for heavy, below-the-fold content; `ng-content` fallback content.
   - v19+: signal inputs `input()` / `input.required()`, `output()`, `model()`; signal queries `viewChild()` / `viewChildren()` / `contentChild()`; `@let` in templates; omit `standalone: true` (it's the default).
   - v20+: `effect()`, `linkedSignal()`, `toSignal()`/`toObservable()` are stable; `*ngIf` / `*ngFor` / `*ngSwitch` are DEPRECATED; new template expression syntax (`**`, `in`, `void`, template literals) where it simplifies code.
   - Newer than v20: apply the same rule. Use only what the repo's installed version marks as stable.
   What to flag in touched code:
   - A deprecated API (in ANGULAR_VERSION) used in new or changed code → [Should fix].
   - A modern equivalent is available and stable, but the PR uses the older pattern → [Nit], or [Should fix] if a repo angular-eslint rule enforces it.
   - Mixed styles inside the same NEW block (e.g. a new template using both `*ngIf` and `@if`) → [Nit] for consistency.
   - Don't flag the old style if the change is a one-line edit inside an untouched legacy block where switching would mean rewriting untouched lines. In that case, at most one optional note.
   For each suggestion: show before → after code for the touched lines only. If a migration schematic exists, mention it scoped to the touched files only, e.g.
   `ng g @angular/core:control-flow --path <file>`, `@angular/core:signal-input-migration`, `@angular/core:output-migration`, `@angular/core:signal-queries-migration`, `@angular/core:inject`, `@angular/core:self-closing-tag`.

F. Reuse & shared-code check (always):
   1. Find candidates in code ADDED by this PR (new or changed lines only):
      - Generic helpers: formatting, parsing, validation, mapping/transforming, date/number/string/array/object utilities, comparators, regexes, constants/enums, type guards.
      - Logic that doesn't depend on the component's own state (it could be a pure function with inputs → output).
      - Repeated blocks: the same or similar logic appearing 2+ times in the PR, or already elsewhere in the repo.
      - Generic UI behaviour or transforms: in Angular, template transforms → pipe, DOM behaviour → directive, stateful or DI-dependent logic → injectable service; generic RxJS pipelines → a shared operator.
      - Duplicated types/interfaces/DTOs.
   2. For each candidate, check whether it ALREADY EXISTS before suggesting anything:
      - `git grep -n` for the function name, likely synonyms (format/parse/to/is/get + noun), distinctive literals/regexes, and key calls inside its body. Search SHARED_DIRS first, then the whole repo.
      - Check whether a dependency already provides it (lodash, date-fns/moment, rxjs operators, Angular built-ins such as DatePipe/CurrencyPipe/Validators, the framework's standard library). Only use dependencies already in package.json / pom / requirements.
      - If the repos root has shared library repos used by this repo, grep those too (`grep -rl … | head -10`).
   3. Decide for each candidate:
      - EXISTS (same behaviour) → [Should fix] Use the existing one. Give its path, show the replacement call, and note any behaviour differences.
      - EXISTS PARTIALLY → [Should fix] Extend or parametrize the existing util instead of adding a near-duplicate. Show the suggested signature change and check its current callers aren't affected.
      - DOESN'T EXIST, but it's generic (used 2+ times in the PR, similar logic exists elsewhere in the repo, or it's clearly component-independent) → [Nit], or [Should fix] if it's duplicated within the PR. Suggest moving it out of the component into a shared location:
        • Follow the repo's existing convention (folder, file naming, barrel/index exports, test file next to it). Propose the exact path and file name, the function signature, and a unit test file.
        • Pick the right form: pure function → utils; DI or state → service in shared/core; template transform → pipe; DOM behaviour → directive; reusable UI → shared component.
        • If no shared folder exists, propose one (e.g. `src/app/shared/utils/`) and mark it [Question], since it sets a new convention the team should agree on.
        • For a library repo: keep the extracted util INTERNAL (don't add it to the public API/index exports) unless it's meant for consumers, because exporting it adds public surface. Cross-check this with section C.
      - Component-specific, or used once and unlikely to be reused → leave it where it is. Don't push premature abstraction; only flag things that are genuinely generic.
   4. Scope: suggestions apply to code this PR adds. If the PR duplicates EXISTING untouched code, cite both locations, but suggest consolidating the old copies only as an optional follow-up (not required for this PR).
   For each finding: show before → after (the component code using the shared util) and a sketch of the shared util and where it would live.

Rules:
- Report EVERY verified finding: no cap, minor ones included. Don't report anything you haven't verified in the code.
- Every finding needs file:line, a clear explanation of the problem, WHY it matters (the concrete risk or cost), and a concrete fix. Include a suggested code snippet when the fix isn't obvious from a one-line description.
- When something is uncertain, phrase it as a question to the developer, not as an assertion.
- Mention things done well where they're genuinely notable (1–3 points), so the review is balanced, including good use of modern Angular syntax or of existing shared utils.
- Don't paste large unchanged code blocks; quote only the lines needed.

Return only this:
### PR #<id> — <title> (<TICKET>) [<mode>, <model>]
**Build:** ✅ passed | ❌ failed (caused by this PR) | ⚠️ pre-existing failure on <dst> | ⏭ skipped — plus the command used, and the key error lines if it failed
**Coverage (changed files, internal note):** ✅ sufficient | ❌ insufficient | ⏭ not measured — functions X% / branches Y% (threshold Z%); list the files below the threshold. Global coverage: deferred.
**Breaking changes:** NONE | FOUND (n) — one line each: what • file:line • affected consumers (count + repos) • intentional per ticket? yes/no/unclear
**Angular syntax (v<ANGULAR_VERSION>):** N/A | ✅ modern | n suggestions (x deprecated-API uses, y modernization nits)
**Reuse & shared code:** ✅ nothing to extract | n findings (x existing utils to reuse, y partial duplicates to merge, z extraction candidates → proposed location)
**Ticket fit:** a paragraph going through each acceptance criterion: ✅ met / ⚠️ partial / ❌ missing, with notes
**Previous comments (DELTA only):** a table of each earlier comment of mine → addressed / not addressed / resolved without a change, with a short note
**Findings summary:** counts per severity (Blocker / Should fix / Nit / Question)

**Draft — overall PR comment** (ready to paste into Bitbucket, addressed to the developer by first name):
- Opening: what the PR does and the overall assessment
- Build result (if it failed)
- Breaking changes (if any; the full discussion section is added below in Step 2b)
- The main themes of the review, grouped (e.g. correctness, tests, performance, reuse, Angular syntax), each with 2–4 sentences of explanation and references to the inline comments
- Reuse & shared code: if there are findings, one paragraph listing the existing utils that should be reused (with paths) and the logic worth extracting, with the proposed shared location and why it's generic
- Angular syntax: if there are suggestions, one short paragraph saying they apply only to the code this PR touches, which Angular version they're based on, and which schematic (if any) can apply them to the touched files
- Coverage: ONLY if function/branch coverage on changed files is insufficient — name the files, their %, and the threshold. Otherwise say nothing about coverage.
- What's done well
- A clear list of what's needed before approval
- Closing

**Draft — inline comments** (one per finding, grouped by file, in line order; ready to paste on that line in Bitbucket):
#### `path/to/file.ext`
- **L<line>** [Blocker|Should fix|Nit|Question] <title>
  <explanation of the problem — 2–5 sentences>
  *Why it matters:* <concrete risk or impact>
  *Suggestion:* <fix>
  ```<lang>
  <suggested code: before → after, a shared-util sketch, or a test case, when helpful>
  ```

**Verdict:** Approve | Comment | Request changes — with a one-line reason
**ESCALATE_BC:** yes if breaking changes were FOUND and you are not opus, otherwise no
---

Verdict rules: a build the PR broke → Request changes. A breaking change that isn't announced in the ticket/CHANGELOG, or has no migration path → Request changes. Any other Blocker → Request changes. Function/branch coverage below the threshold on changed files → Should fix (Request changes only if the uncovered branches are on critical paths such as error handling, auth, or data writes). Reuse findings alone → Comment (Request changes only if the PR re-implements an existing util with different behaviour, which risks inconsistency). Angular syntax suggestions alone never cause Request changes, unless a repo lint rule enforces them and the build/lint fails. An intentional and documented breaking change → Comment, at minimum. Global coverage never affects the verdict.

## Step 2b — Breaking-change discussion (only if breaking changes were FOUND)
- If the reviewer was opus, it writes this section itself, in the same pass.
- Otherwise (ESCALATE_BC=yes), launch ONE opus general-purpose subagent. Give it ONLY: the PR link, local repo path, diff range, the ticket summary + acceptance criteria, the "Breaking changes" lines, and the consumer list, and tell it to read just the relevant hunks and their callers.
Either way, produce this section, which is added to the overall draft comment (no word limit; be thorough but concrete):

#### ⚠️ Breaking changes — needs discussion before merge
For EACH breaking change:
1. **What breaks:** before vs after (signature, payload, schema, or behaviour), with file:line and a short code comparison.
2. **Who is affected:** the consumers found (repos/services/modules), external clients if it's a public API, and data already stored.
3. **Impact & severity:** compile-time vs runtime failure, silent data corruption risk, and the blast radius if deployed as is.
4. **Was it intended?** Quote what the ticket says (or note its silence), and say whether the version bump and CHANGELOG reflect it.
5. **Options**, each with its pros, cons, and effort:
   a) Make it backward-compatible (keep the old API as a deprecated alias/adapter, default the new parameter, add new fields instead of renaming, expand-then-contract migration).
   b) Ship it as an explicit breaking release (major version bump, CHANGELOG entry, migration guide, deprecation window).
   c) Put it behind a feature flag or versioned endpoint (/v2) and run both versions in parallel.
   d) Split the PR: non-breaking groundwork now, the breaking switch later.
6. **Recommended path** and why, with a code sketch of the backward-compatible version where that applies.
7. **Migration & rollout plan:** the steps for consumers, deploy order across services, data migration/backfill, rollback plan, and who has to be notified or coordinated with.
8. **Open questions for <developer first name>:** specific questions the developer must answer before this can merge.

## Step 3 — Present
Show the subagent's output in full (don't shorten or rewrite it), with the Step 2b section inserted into the overall draft comment where breaking changes are mentioned.
Above it, add a 2-line header: the verdict, and the counts of Blockers / Should fix / Nits / Questions.
Then ask me whether to post it. Only if I confirm, post the overall comment and each inline comment as PENDING (draft) comments via addBitbucketRepoPullRequestComment (pending=true, inlinePath/inlineToLine for inline ones), so nothing is published until I submit the review in Bitbucket.
