#!/usr/bin/env bash
# Installs the pds-* skills on this machine.
# Installs to Claude Code (~/.claude/skills) and Cursor (~/.cursor/skills; Cursor support to be verified).
# Usage: ./install-skills.sh
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
if   [ -d "$HERE/skills" ];    then SRC="$HERE/skills"
elif [ -d "$HERE/../skills" ]; then SRC="$HERE/../skills"
else echo "skills folder not found next to this script" >&2; exit 1; fi

targets=("$HOME/.claude/skills" "$HOME/.cursor/skills")

for t in "${targets[@]}"; do
  mkdir -p "$t"
  for d in "$SRC"/pds-*/; do
    name="$(basename "$d")"
    rm -rf "$t/$name"
    cp -R "$d" "$t/$name"
  done
  echo "installed $(ls -d "$SRC"/pds-*/ | wc -l | tr -d ' ') skills to $t"
done
echo "Start a new Claude Code session (or restart Cursor) to load them."
