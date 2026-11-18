# Lesson candidate: Every acceptance criterion has a check (a story or an automated test)

Status: candidate, widened after checking other PRs on 2026-11-18. It meets the repeat rule (2 PRs), but the reviewer has not seen the wider wording. It was first written as "every acceptance criterion can be checked in Storybook". It may fit better as an edit to Mayank 12 (follow the ticket) or to item 1 of the definition of done than as a new lesson.

### Every acceptance criterion has a check (a story or an automated test)
- **Do:** make sure each acceptance criterion of the ticket can be checked, by a story that binds the inputs it needs, or by an automated test.
- **Avoid:** an acceptance criterion with no way to check it: story controls that are not bound to anything, or a diff with stories, docs and styles but no tests.
- **Why:** the reviewer could not check the criterion, and nothing "locks in the behavior".
- **Example:** a story with 22 columns, `rowHover: true` and `selectionMode: 'multiple'` to check the hover criteria. Or "a small test asserting the default gaps and `.px-gutter-0` to `.px-gutter-6`".
- Seen in: PR 395, 385

### Evidence (checked against the full comment text, 2026-11-18)
- **PR 395:** the reviewer could not check the wide-table hover case in Storybook (AC2, AC5) and asked for a play function that checks the layout.
- **PR 385, comment 886441518, point 4:** "No automated tests for the acceptance criteria. The diff changes stories, docs and SCSS but no specs. ... A small test asserting the default gaps and .px-gutter-0 to .px-gutter-6 would lock in the behavior". Close match to the wider wording. It asks for specs, not stories.
- **PR 391, comment 905032915:** "Three things still stand between this and the PR's acceptance criteria". About meeting the criteria, not about checking them. Partial.
- **PR 381, comment 885026190:** controls that do nothing in most stories. This is the existing lesson Anat 9, which already lists PR 381.

### Proposal details
- **Occurrences:** 2 PRs (395 and 385) with the wider wording.
- **Matching lesson in the brain:** Anat 9 (controls that affect the story), Mayank 12 (follow the ticket), and item 1 of the definition of done (the ticket's own definition of done is met).
- **Missed despite a lesson:** no. Written before the brain existed.
- **Fits our code:** yes, the examples are from this repo.
- **Open question for the reviewer:** a new lesson, or a sentence added to Mayank 12 / definition of done item 1?
- **Target file:** `lessons/by-reviewer/lessons-mayank.md` (edit to lesson 12), or `guidelines/definition-of-done.md` (item 1).
- **Person's decision:** pending.
