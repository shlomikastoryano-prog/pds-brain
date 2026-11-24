# pds-brain

The shared knowledge base of the phenom-ds design system team. AI agents (Claude Code and Cursor) read it before they write or check code, and people use it as the written source of the team's rules and lessons.

## What is inside
| Folder | What it holds |
|--------|---------------|
| `guidelines/` | Rules: Angular, accessibility, the definition of done before a PR, the ticket template, the learning loop, and repo checks (proposal). |
| `lessons/by-reviewer/` | Lessons from real review comments, approved by the team reviewer. |
| `lessons/candidates/` | Comments seen once. Not lessons yet. Agents that write code do not read this folder. |
| `lessons/external/` | Ideas from outside libraries. Use them as ideas only. |
| `templates/` | The template for proposing a new lesson. |
| `agents/` | Prompts of agents (drafts, not all tested). |
| `skills/`, `scripts/` | Standalone Claude Code skills built from the files above, and the scripts that build and install them. Do not edit `skills/` by hand: the next build overwrites it. |
| `sources/` | Original documents, for people. Agents must not read it. |

## How it is used
- **In the phenom-ds repo** the brain is a git submodule in `brain/`. `AGENTS.md` tells the agents which file to read for which task. After you pull the repo, run `git submodule update --init` once.
- **Update the brain in phenom-ds:** `git submodule update --remote brain`, then commit the new pointer.
- **As skills:** run `scripts/pack-skills.sh` to build `dist/pds-skills.zip`. The zip has an install guide (`INSTALL-SKILLS.html`) and an installer for Mac.

## How it changes
- Nothing enters the brain without the team reviewer's approval, as a change request in this repo. Agents only read it. They never write to it on their own.
- A new lesson starts as a candidate. It becomes a lesson when the same comment appears in a second PR. See `guidelines/learning-loop.md`.
- Items marked "Open" or "suggestion" in a file are not decided yet. Say so when you rely on one.
