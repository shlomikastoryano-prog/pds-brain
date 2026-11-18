# Definition of done: a PR is ready for review when

Status: approved by the team reviewer. Open items are marked in the text.
Source: the checklist in the guidance PDF "Working with Claude End-to-End: From Jira Ticket to Merged PR" (Oct 29, 2026).
Use: the pre-check agent (SHELL-742) reads this list before a PR is opened. A task is done only when an automated check says so, not when it looks finished.

| # | Item | What the pre-check agent must check |
|---|------|--------------------------------------|
| 1 | The ticket's own definition of done is met | Read the definition of done from the Jira ticket as it is now, and its history since the work started (edits to the description and comments). Mark what changed compared with the original ticket, and confirm that each point, including the new or changed ones, has a check. Open: can the agent read the Jira history? (to be verified) |
| 2 | The reviewer agent ran and every issue was fixed | The review step runs before the PR opens, and no issue is left open |
| 3 | Pre-commit checks pass | Lint, format, commit format and Jira key |
| 4 | Integration tests are added and pass | Tests exist for the change and pass. Reviewer: integration tests matter most for table-style patterns where much of the data comes from the backend. Open: is a documentation page with an implementation example needed for such patterns? |
| 5 | Storybook stories and play functions are added; Chromatic shows only intended changes | Stories and play functions exist for the change. Reviewer: play functions are wanted in principle, and are a feature to start using. Open: does our Storybook configuration run them? Chromatic: the reviewer asked for deeper research on the addon and how to use it. |
| 6 | Accessibility check passes | AXE runs on every new or changed Design System element, through its Storybook stories. AXE starts as a **warning** (does not block the PR); the reviewer may tighten it later. The agent returns the AXE result and a list of manual checks. The manual checks are done by the designer together with the agent |
| 7 | The PR description links the ticket and notes any feature flag | The description has the ticket link and the feature flag note, and its claims match the change |

## Proof that a check ran
A check counts only if the agent's report shows it ran. "Nothing found" is not proof.
- **Accessibility (item 6):** the report names every story AXE ran on, and gives the number of violations per story. A report with no story list, or with zero stories, is "not run", not "passed".
- **Manual accessibility checks:** the report lists each manual check (keyboard flow, focus order, screen reader, long text) and marks it done or not done by the designer. Not done means the PR is not ready.
- **Every other item:** the report shows what was checked (command, files or stories) and the result.
- **Testing the agent:** once built, run it on a change with a known accessibility violation. It must report that violation. If it does not, the check does not work.

## Open questions for the team
- Do integration tests apply beyond table-style patterns with backend data? Is a documentation page with an implementation example needed for those patterns?
- Does our Storybook configuration run play functions (for example in CI)? The reviewer does not know, and wants to start using them.
- Chromatic: research the addon and how to use it (reviewer, 2026-11-18). Is it in use, and is its cloud connection set up?

## What the code of the DS repo shows today (checked 2026-11-18, read only)
- **Play functions:** 32 story files have `play:`. There is no runner for them: no `@storybook/test-runner`, no `@storybook/addon-vitest`, no vitest or playwright, and no `test-storybook` script. `npm test` runs Jest only. So play functions run only when a story is opened in Storybook, not automatically.
- **Chromatic:** only the addon `@chromatic-com/storybook` is installed (`package.json`, `.storybook/main.ts`). There is no Chromatic CLI, script, config file or CI mention in the repo. If it is connected, it is not through this repo. To be verified.
- **AXE:** `@storybook/addon-a11y` is installed and shows a panel in the browser. Nothing runs it automatically on every story. For the pre-check agent to run AXE on every story, a runner has to be added (to be verified).
- **Not known:** the shared Jenkins pipeline has a step named `executeUiTests`. Its content is not in this repo, so it is not known whether it runs any Storybook tests. A question for whoever owns the pipeline.

