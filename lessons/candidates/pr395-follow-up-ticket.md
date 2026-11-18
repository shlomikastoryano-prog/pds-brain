# Lesson candidate: A deferred item gets a follow-up ticket, linked in the PR notes

Status: ready for reviewer approval. It repeated in another PR (see Occurrences), so it meets the repeat rule in `guidelines/learning-loop.md`. Not a lesson until the reviewer approves it.

### A deferred item gets a follow-up ticket, linked in the PR notes
- **Do:** when you defer work to a follow-up, create the ticket and write its number in the PR notes. State what the ticket covers.
- **Avoid:** writing "deferred to a follow-up" with no ticket number.
- **Why:** reason not given in the comments. Without a number, the deferred item cannot be tracked.
- **Example:** "play-function assertions deferred to SHELL-858", and "SHELL-819 covers blockFor, the padding assertion and emptyStateArgTypes".
- Seen in: PR 395, 389, 391, 383, 378

### Evidence (checked against the full comment text, 2026-11-18)
- **PR 395:** play-function assertions were deferred with no ticket id. The reviewer asked to create or link the ticket, and asked whether the padding assertion was part of the existing follow-up.
- **PR 389, comment 890462796:** "no ticket exists for it. Please open a small ticket." Full match.
- **PR 391, comment 900107862:** "These need separate tickets; I see no ticket number in the thread." Full match. Comment 905032915, question 4, asks for the ticket numbers of the open bugs.
- **PR 383, comment 885164263:** "#1-#3 can be follow-ups, but they should be linked to a ticket". Full match.
- **PR 378, comment 886526852:** "Either fix it here or file the ticket. The description still says SHELL-XXX." Full match.
- **PR 394, comment 893112618:** asks to split a part into its own PR and ticket. Partial match (a request to split, not to link a deferral).

### Proposal details
- **Occurrences:** 5 PRs with a full or near match, across several authors.
- **Matching lesson in the brain:** none. Anat 8 and the definition of done (item 7) cover the ticket link of the PR itself, not deferred items.
- **Missed despite a lesson:** no. These PRs were written before the brain existed.
- **Fits our code:** this is about PR process, not code.
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson), and a line in `guidelines/definition-of-done.md` item 7.
- **Person's decision:** pending.
