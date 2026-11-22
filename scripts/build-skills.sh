#!/usr/bin/env bash
# Builds standalone Claude Code skills from the brain files into skills/.
# The brain is the only source. Do not edit skills/ by hand: the next run overwrites it.
# Install on a machine: cp -R skills/* ~/.claude/skills/
set -euo pipefail
cd "$(dirname "$0")/.."

OUT=skills
rm -rf "$OUT"
mkdir -p "$OUT"

# build <name> <description> <intro line> <source files...>
build() {
  local name="$1" desc="$2" intro="$3"; shift 3
  local dir="$OUT/$name"
  mkdir -p "$dir/references"
  local list=""
  for f in "$@"; do
    [ -f "$f" ] || { echo "missing source: $f" >&2; exit 1; }
    cp "$f" "$dir/references/$(basename "$f")"
    list="$list- \`references/$(basename "$f")\`"$'\n'
  done
  cat > "$dir/SKILL.md" <<MD
---
name: $name
description: "$desc"
---

<!-- Generated from the pds-brain repo by scripts/build-skills.sh. Do not edit: changes are overwritten. -->

$intro

Read these files before you act:
$list
Items marked "Open" or "suggestion" in the files are not decided yet. Say so when you rely on one.
MD
  echo "built $name"
}

build pds-angular-guidelines \
  "Angular rules for the phenom-ds design system (Angular 19, PrimeNG 17). Use when writing or changing component code, templates or services in phenom-ds." \
  "Rules for writing Angular code in phenom-ds. Use the \"Apply now\" list and skip the \"Not for our version\" list." \
  guidelines/angular.md

build pds-accessibility \
  "Accessibility rules for phenom-ds components (WCAG AA, AXE, focus, ARIA). Use when building or reviewing a component or pattern in phenom-ds." \
  "Accessibility rules for phenom-ds." \
  guidelines/accessibility.md

build pds-review-lessons \
  "Lessons from real PR reviews in phenom-ds, by reviewer. Use when writing, fixing or checking code in phenom-ds before a PR." \
  "Lessons learned from review comments on phenom-ds PRs. Apply them to the code you write or check." \
  lessons/by-reviewer/lessons-anat.md lessons/by-reviewer/lessons-mayank.md lessons/by-reviewer/lessons-naresh.md

build pds-definition-of-done \
  "Definition of done for a phenom-ds change: the checklist to run before opening a PR. Use before a PR is opened or when a developer asks if a change is ready." \
  "The checklist a phenom-ds change must pass before a PR. Go through each item and report what passed, failed or could not be checked." \
  guidelines/definition-of-done.md lessons/by-reviewer/lessons-anat.md lessons/by-reviewer/lessons-mayank.md lessons/by-reviewer/lessons-naresh.md

build pds-ticket-template \
  "Template for a phenom-ds Jira ticket. Use when writing or checking a ticket." \
  "How a phenom-ds ticket is written." \
  guidelines/ticket-template.md

build pds-learning-loop \
  "How a review comment becomes a lesson in the phenom-ds brain. Use when handling review comments on a PR or proposing a new lesson." \
  "The learning loop and the proposal template. The candidate lessons live in the brain repo (lessons/candidates/) and are not part of this skill. The agent never changes the brain by itself." \
  guidelines/learning-loop.md templates/lesson-proposal.md lessons/candidates/README.md

build pds-reviewer-draft \
  "Drafts a thorough review of one Bitbucket PR for the reviewer (build, coverage, breaking changes, reuse, Angular syntax). Drafts only, never posts. Use when the reviewer asks for a PR review draft." \
  "A prompt for drafting a PR review. It was shared by the team reviewer and is not adapted to phenom-ds yet." \
  agents/reviewer-draft.md
