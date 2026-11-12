# Definition of done: a PR is ready for review when

Status: draft, not yet approved.
Source: the checklist in the guidance PDF "Working with Claude End-to-End" (Oct 29, 2026).
Use: the pre-check agent (SHELL-742) reads this list before a PR is opened. A task is done only when an automated check says so, not when it looks finished.
Note: the pre-check agent is not built yet. The existing `phenom-ds-validator` is only a starting point to rebuild from; the column "Starting point" shows what it already does, so we know what to reuse and what to add.

| # | Item | Starting point (existing validator) | To build |
|---|------|--------------------------------------|----------|
| 1 | The ticket's own definition of done is met | Requirements coverage, only if requirements are passed in | Read the ticket's definition of done from Jira directly |
| 2 | The reviewer agent ran and every issue was fixed | Nothing | Make the review step part of the flow, before the PR opens |
| 3 | Pre-commit checks pass | Lint, format, commit format and Jira key | Reuse |
| 4 | Integration tests are added and pass | Runs the full suite and checks specs for new inputs and outputs. No integration test check | Decide if integration tests apply to a component library, then add the check |
| 5 | Storybook stories and play functions are added; Chromatic shows only intended changes | Checks stories (variants, states, controls, docs) | Add a play-function check. Decide if Chromatic is used |
| 6 | Accessibility check passes | Checks rules on the diff. Cannot run AXE or test keyboard and screen reader | Add an AXE run and a list of manual checks |
| 7 | The PR description links the ticket and notes any feature flag | Checks the description's claims against the diff | Add: ticket link present, feature flag noted |

## Open questions for the team
- Do integration tests (from the backend response to the final UI state) apply to this repo?
- Is Chromatic in use, and is its cloud connection set up?
