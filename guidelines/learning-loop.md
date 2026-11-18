# Learning loop: from a review comment to a lesson

Status: proposal, not yet reviewed. Items marked "Open" are decisions nobody has made yet.
Purpose: a comment a reviewer wrote once should not need to be written again. The loop turns a review comment into a written lesson that the agents read.
Where it is built: this file defines the loop (SHELL-822). The comment-handling agent (SHELL-743) runs steps 1 to 3.

## The loop
1. **A review comment arrives** on a PR.
2. **The agent sorts it.** Code change, reply only, decision, follow-up ticket, or already done. For each comment that needs a code change, it checks the brain for a lesson that covers it.
   - **A lesson exists.** The agent fixes the code by the lesson and marks the comment "missed despite lesson". This is a signal to fix the brain: the agent did not read the file (routing in `AGENTS.md`), or the lesson is unclear.
   - **No lesson exists.** The agent drafts a lesson proposal using `templates/lesson-proposal.md`.
3. **A person filters.** A one-time preference of a reviewer is not a lesson. The person who handles the PR decides whether the comment is general.
4. **The reviewer approves.** The proposal becomes a change request in the brain repo. Nothing enters the brain without approval. The agent never writes to the brain on its own.
5. **The brain is updated.** After the merge, the code repo updates its brain pointer (`git submodule update --remote brain`, then a commit). Others get the lesson on their next pull.
6. **Measure.** Each lesson records the PRs it came from ("Seen in"). Later, count new comments that match an existing lesson. If they keep coming, the lesson does not work.

## Rules
- The agent only reads the brain. Every change needs a person's approval.
- A proposal always shows its source: the PR and the comment.
- A comment the pre-check agent (SHELL-742) missed, or one that repeats, is a strong candidate for a lesson.
- A lesson that does not change what the agent does is not worth adding. Check that it is specific enough to act on.

## Open decisions (proposals, to be agreed)
| Question | Proposal |
|----------|----------|
| Who approves a lesson? | The team reviewer, as a change request in the brain repo, like a code PR. |
| When does a comment become a lesson? | Propose on the first occurrence, mark it "single occurrence". Promote when it repeats. |
| How does the approver learn a proposal is waiting? | Open. Slack was dropped (SHELL-826, decision 2). |
| Who can write to the brain repo? | Open. Today only the repo owner. After the move to Bitbucket, the team. |
| Who updates the brain pointer in the code repo, and when? | Open (SHELL-826, decision 7). |
| How is it measured? | Count comments per lesson per period, from the "Seen in" lists. Success: fewer repeated comments (SHELL-825, decision 4). |
