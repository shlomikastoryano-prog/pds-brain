# Learning loop: from a review comment to a lesson

Status: proposal, not yet reviewed. Items marked "Open" are decisions nobody has made yet.
Purpose: a comment a reviewer wrote once should not need to be written again. The loop turns a review comment into a written lesson that the agents read.
Where it is built: this file defines the loop (SHELL-822). The comment-handling agent (SHELL-743) runs steps 1 to 3.

## The loop
1. **A review comment arrives** on a PR.
2. **The agent sorts it.** Code change, reply only, decision, follow-up ticket, or already done. For each comment that needs a code change, it checks the brain for a lesson that covers it.
   - **A lesson exists.** The agent fixes the code by the lesson and marks the comment "missed despite lesson". This is a signal to fix the brain: the agent did not read the file (routing in `AGENTS.md`), or the lesson is unclear.
   - **No lesson exists.** The agent drafts a lesson proposal using `templates/lesson-proposal.md` and saves it as a **candidate** in `lessons/candidates/`, marked "single occurrence". A candidate is not a lesson. The agents that write code do not read it.
3. **A person filters.** A one-time preference of a reviewer is not a lesson. The person who handles the PR decides whether the comment is general.
4. **The reviewer approves.** The proposal becomes a change request in the brain repo. Nothing enters the brain without approval. The agent never writes to the brain on its own.
5. **The brain is updated.** After the merge, the code repo updates its brain pointer (`git submodule update --remote brain`, then a commit). Others get the lesson on their next pull.
6. **Measure.** Each lesson records the PRs it came from ("Seen in"). Later, count new comments that match an existing lesson. If they keep coming, the lesson does not work.

## Rules
- The agent only reads the brain. Every change needs a person's approval.
- A proposal always shows its source: the PR and the comment.
- A comment the pre-check agent (SHELL-742) missed, or one that repeats, is a strong candidate for a lesson.
- A lesson that does not change what the agent does is not worth adding. Check that it is specific enough to act on.

## When a candidate becomes a lesson
A new comment is recorded as a candidate and becomes a lesson only when it **repeats**. A single comment can be one reviewer's preference, and too many lessons make the important ones hard to find.
- **What counts as a repeat:** the same comment in a **different PR**, or from a different reviewer. The same request repeated inside one PR counts as one occurrence.
- **How many:** 2 occurrences. (To be confirmed with the reviewer.)
- **How a repeat is found:** when the agent sorts a comment and finds no lesson, it also checks `lessons/candidates/`. A match adds the new PR to the candidate's "Seen in". At 2 occurrences the candidate goes to the reviewer for approval.
- **Exception:** accessibility, security and breaking changes do not wait for a repeat. The reviewer can approve them on the first occurrence.

## Open decisions
| Question | Status |
|----------|--------|
| When does a comment become a lesson? | Decided: when it repeats (see above). Open: the exact number, proposed 2. |
| Who approves a lesson? | Proposal: the team reviewer, as a change request in the brain repo, like a code PR. |
| How does the approver learn a proposal is waiting? | Open. Slack was dropped (SHELL-826, decision 2). |
| Who can write to the brain repo? | Open. Today only the repo owner. After the move to Bitbucket, the team. |
| Who updates the brain pointer in the code repo, and when? | Open (SHELL-826, decision 7). |
| How is it measured? | Count comments per lesson per period, from the "Seen in" lists. Success: fewer repeated comments (SHELL-825, decision 4). |
