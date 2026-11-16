# Definition of done: a PR is ready for review when

Status: draft, not yet approved.
Source: the checklist in the guidance PDF "Working with Claude End-to-End: From Jira Ticket to Merged PR" (Oct 29, 2026).
Use: the pre-check agent (SHELL-742) reads this list before a PR is opened. A task is done only when an automated check says so, not when it looks finished.

| # | Item | What the pre-check agent must check |
|---|------|--------------------------------------|
| 1 | The ticket's own definition of done is met | Read the definition of done from the Jira ticket and confirm each point |
| 2 | The reviewer agent ran and every issue was fixed | The review step runs before the PR opens, and no issue is left open |
| 3 | Pre-commit checks pass | Lint, format, commit format and Jira key |
| 4 | Integration tests are added and pass | Tests exist for the change and pass. Reviewer: integration tests matter most for table-style patterns where much of the data comes from the backend. Open: is a documentation page with an implementation example needed for such patterns? |
| 5 | Storybook stories and play functions are added; Chromatic shows only intended changes | Stories and play functions exist for the change. Open: is Chromatic in use? Reviewer: needs a deeper check. |
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
- Is Chromatic in use, and is its cloud connection set up? Are play functions required? (Reviewer: needs a deeper check.)
