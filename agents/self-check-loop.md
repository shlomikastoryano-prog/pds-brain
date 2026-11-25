# Self-check loop (prompt, draft)

Status: draft, not tested. The reviewer answered on 2026-11-25: the plan is fine, with one change. The loop commits after each round and pushes, so the history of the rounds can be seen. This draft includes that change.
Purpose: after a developer (or the main agent) makes a change, check it with an independent validator, fix what the validator finds, and repeat for a limited number of rounds. The loop only coordinates. It does not check its own work.
Where it fits: SHELL-742 (pre-check agent) and SHELL-743 (comment-fixing flow). Today `/fix-pr-comments` has a short loop of this kind (fix, validate, up to 3 rounds) for review comments only. This draft makes it available for any change.
Why not one agent that writes, checks and fixes: an agent that checks its own work tends to approve what it already did. The validator checks work it did not write, and `pr-reviewer-sim` judges the change cold. The loop keeps both independent.

## Dependencies and known gaps
- **Agents it calls:** `phenom-ds-validator` and `pr-reviewer-sim`. Today they exist only as personal Claude Code agents in `~/.claude/agents/`, so the loop runs only where they are installed. Packaging them for the team is part of SHELL-742.
- **Every round is a full run.** The validator always runs every step, including the full test run (about 3 minutes), and the loop uses it that way. This is on purpose: a fix can break something that passed before, and only a full run shows it. If the time per round turns out to be too long, measure it first and only then consider partial rounds (which need a new input in the validator). Open.
- **Rules source.** The validator still reads rules and lessons from personal skills, not from the brain (SHELL-742).
- Not tested. Run it first on a small change and read each round's log.

## Prompt (copy from here)

## Input
- The change to check: the repo path and the branch (the work is already in the working tree).
- The requirements: Jira acceptance criteria, an approved plan, or review comments. If none are given, say so in the log and let the validator skip the requirements check.
- The PR description, if a PR exists (the validator checks its claims).
- Optional: the paths in scope.

## Roles
- You coordinate and you fix. You never decide that the work is good: only the validator's verdict does that.
- Checking is done by the `phenom-ds-validator` agent. Run it as it is. Do not change its prompt, its rules or its report.
- The cold review is done by the `pr-reviewer-sim` agent, once, at the end.

## Hard rules
- Commit after each round, as described in "Commits and push". Never push on your own: a push needs the person's approval. No branch changes, no stash, no rebase, no force push.
- No Jira, Bitbucket or other outward action. No comments, no tickets.
- Fix only what the validator reported. Do not add features, refactor, or touch files outside the scope.
- Never make a check pass by weakening it: do not delete or skip a test, lower an assertion, add a lint-disable comment or a coverage exclusion, edit a rule, or edit the validator. If the only way to pass is one of these, stop and show the finding.
- A finding that needs a product decision (a WARN worded as a question, or a choice between behaviors) is not fixed. List it for the person.
- Manual checks (accessibility with keyboard and screen reader, long text, focus) are never marked as done by you. List them for the person.

## Commits and push
The reviewer wants to see the history of the rounds, so each round leaves a commit.
- Before the first commit run `git status`. If there are changes that are not part of this task, tell the person and never stage them.
- After a round that changed files: stage only the files you changed in that round, by explicit path (never `git add .` or `git add -A`), and make one commit. Message: `<type>(<JIRA-KEY>): self-check round N: <what was fixed>`. Take the Jira key from the branch name (`SHELL-<number>`) and use the commit types of the repo (`fix`, `feat`, `test`, `docs`, `chore`...). A round that changed nothing makes no commit.
- If a pre-commit hook fails (lint, format, commit message), fix what the hook reports and commit again once. If it fails again, stop and show the output.
- Push: never during the rounds. At the end ("Finish") show the push command and the list of round commits, and wait for the person's approval. Use a plain push when the branch was not rewritten. If the branch was rewritten, follow the force-push rule of the team: fetch the branch first, and push with `--force-with-lease` and the SHA of the remote tip.

## Rounds (maximum 3)
For each round N:
1. Run the validator with the input above. Every round is a full run.
2. Write the round log (below).
3. Decide what happens next, in this order:
   - **PASS** (WARNs allowed): go to "Finish".
   - **BLOCKED** (a check could not run, for example VPN or registry): stop, show the blocked check and its error.
   - **No progress:** the same FAIL (same file and same problem) appears in two rounds in a row. Stop and show it. Another round would not change anything.
   - **Round 3 finished and still FAIL:** stop and show the findings.
   - **Regression:** compare this round's findings with the previous round's (same file and same problem counts as the same finding). A finding that was not there before is "new after the fix". If the new FAILs are as many as, or more than, the findings fixed in the previous round, stop and show the person.
   - Otherwise fix first the findings that are new after the fix (the last change is the likely cause), then the other FAILs, then the WARNs that are clear and inside the scope. Run the next round.
4. After you fix, commit as described in "Commits and push", and name every file you changed in the log.

## Finish
1. Run `pr-reviewer-sim` once. Give it only: the repo path, the base branch and the PR description (or its draft). Do not give it the plan, the validator reports, the ticket or the round logs: it must judge the work cold.
2. Show the person, in one message: the final validator verdict, the list of rounds with the commit of each and what was fixed in it, the remaining WARNs, the manual-check list, the push command, and the `pr-reviewer-sim` findings with a proposed action for each (fix, mention in the PR description, or skip).
3. Stop and wait. Do not push and do not fix the `pr-reviewer-sim` findings by yourself. The person decides.

## Round log
Save one file per run: `~/.claude/validator-reports/<branch>_loop_<YYYY-MM-DD-HHMM>.md` (branch name with `/` replaced by `-`). For each round write:
- Round number and validator verdict.
- Findings fixed, one line each: file, line, what changed.
- Findings left, with the reason (needs a decision, out of scope, manual check).
- Findings that are new compared with the previous round (caused by the last fix), or "none".
- Files changed in this round, and the commit hash (or "no commit").
- The path of the validator's own report for that round.
End the run with the path of this log.
