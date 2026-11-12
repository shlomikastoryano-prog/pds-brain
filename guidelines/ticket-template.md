# Jira ticket template

Status: draft, not yet approved. To be agreed with the team (the PDF lists this as a next step).
Source: the ticket fields in the guidance PDF "Working with Claude End-to-End" (Oct 29, 2026).
Why: the agents read the ticket directly from Jira, so the ticket is the prompt. A vague ticket gives a vague PR.
Use: the ticket-picker (SHELL-745) checks that every field is filled before work starts. The planner (SHELL-746) reads the code area to build the plan.

## Fields

| Field | What to write | Why the agent needs it |
|-------|---------------|------------------------|
| Description | What is changing and why, in a few sentences | Sets the goal and the reason, so the plan can be checked against it |
| Content | Exact copy, labels, states, links to designs | Prevents invented text and wrong states |
| Code area | The starting file, plus 2-3 existing files to copy patterns from | The most useful line: the agent starts in the right place and follows an existing pattern |
| Definition of done | What must be true for the task to be finished (see `definition-of-done.md`) | Gives an automated end point |
| Related PRs / files | Earlier work on the same feature | Shows past decisions and review comments |
| Feature flag | Whether the change sits behind a flag, and which one | Needed for the PR description and the production check |
| Special cases | Edge cases, empty states, errors, permissions, RTL | These are where review comments appear (see lessons) |

## Example of the code area line
Start in `projects/phenom-ds/src/lib/components/px-<name>/px-<name>.component.ts`. Follow the pattern in `px-<example-1>`, `px-<example-2>` and `px-<example-3>`.

## Open questions for the team
- Which fields are required, and which can stay empty?
- Is the template a Jira description template, or a separate form?
- Who checks that a ticket is ready: the designer, or the ticket-picker agent?
