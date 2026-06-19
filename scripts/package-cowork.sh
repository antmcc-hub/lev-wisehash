#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"
mkdir -p "$DIST"

while IFS= read -r skill_md; do
  skill_dir="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_dir")"
  parent_dir="$(dirname "$skill_dir")"
  output="$DIST/${skill_name}.skill"
  (cd "$parent_dir" && zip -r "$output" "$skill_name" -x "*.DS_Store" -x "*/__pycache__/*" -x "*.pyc" >/dev/null)
  echo "packaged: dist/${skill_name}.skill"
done < <(find "$ROOT/plugins/lev-wisehash/skills" -name SKILL.md | sort)
