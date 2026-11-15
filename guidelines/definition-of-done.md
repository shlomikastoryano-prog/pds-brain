# Definition of done: a PR is ready for review when

Status: draft, not yet approved.
Source: the checklist in the guidance PDF "Working with Claude End-to-End: From Jira Ticket to Merged PR" (Oct 29, 2026).
Use: the pre-check agent (SHELL-742) reads this list before a PR is opened. A task is done only when an automated check says so, not when it looks finished.

| # | Item | What the pre-check agent must check |
|---|------|--------------------------------------|
| 1 | The ticket's own definition of done is met | Read the definition of done from the Jira ticket and confirm each point |
| 2 | The reviewer agent ran and every issue was fixed | The review step runs before the PR opens, and no issue is left open |
| 3 | Pre-commit checks pass | Lint, format, commit format and Jira key |
| 4 | Integration tests are added and pass | Tests exist for the change and pass. Open: do integration tests (backend response to final UI state) apply to a component library? |
| 5 | Storybook stories and play functions are added; Chromatic shows only intended changes | Stories and play functions exist for the change. Open: is Chromatic in use? |
| 6 | Accessibility check passes | An automated accessibility run (AXE) passes, and a list of manual checks is returned |
| 7 | The PR description links the ticket and notes any feature flag | The description has the ticket link and the feature flag note, and its claims match the change |

## Open questions for the team
- Do integration tests (from the backend response to the final UI state) apply to this repo?
- Is Chromatic in use, and is its cloud connection set up?
