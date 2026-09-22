#!/bin/sh
set -eu
expected="x-post-writer x-content-planner x-reply-handler x-humanizer x-thread-architect x-repurposer x-profile-optimizer x-community-manager x-analytics x-social-listener x-quote-post-analyst x-safety-review"
actual=$(find skills -mindepth 1 -maxdepth 1 -type d -printf '%f ' | sed 's/ $//' | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//')
want=$(printf '%s' "$expected" | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//')
[ "$actual" = "$want" ] || { echo "wrong skill set" >&2; exit 1; }
for path in README.md SKILL.md CLAUDE.md .codex-plugin/plugin.json .claude-plugin/plugin.json .agents/plugins/marketplace.json assets/x-skills-workflow.svg scripts/selftest.py references/socialbu-publishing.md; do [ -s "$path" ] || { echo "missing $path" >&2; exit 1; }; done
python3 -c "import json; d=json.load(open('.codex-plugin/plugin.json')); assert d['name']=='x-skills' and d['interface']['displayName']=='X Skills'"
echo 'validation passed: X Skills'
