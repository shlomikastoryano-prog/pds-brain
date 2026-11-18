# Lesson candidate: Answer every review request: do it, or say why not

Status: ready for reviewer approval. It repeated in another PR (see Occurrences), so it meets the repeat rule in `guidelines/learning-loop.md`. Not a lesson until the reviewer approves it.

### Answer every review request: do it, or say why not
- **Do:** for each request in a review, either do it or write why you decline. Do not leave one without an answer.
- **Avoid:** leaving a request or a question without a reply in later rounds.
- **Why:** an unanswered request cannot be told apart from a forgotten one, and the reviewer cannot verify the related acceptance criterion.
- **Example:** the reviewer asked for `containerWidth` (375px) and `showRows` controls. They were neither added nor declined, and the reviewer asked again: "add them, or say why not".
- Seen in: PR 395, 391

### Evidence (checked against the full comment text, 2026-11-18)
- **PR 395:** a request from the first round stayed without an answer until the third round.
- **PR 391, comment 905034423:** "The helper stories still run in the test runner (my round 1 and 3 question, no reply yet)." The requested action is "fix it, or say it is intended". Full match.
- **PR 391, comment 905032915:** the reviewer's summary lists the points still open from earlier rounds.

### Proposal details
- **Occurrences:** 2 PRs (395 and 391), exactly at the threshold, with different authors.
- **Matching lesson in the brain:** none.
- **Missed despite a lesson:** no. Written before the brain existed.
- **Fits our code:** this is about review process, not code.
- **Target file:** `lessons/by-reviewer/lessons-anat.md` (new lesson).
- **Person's decision:** pending.
