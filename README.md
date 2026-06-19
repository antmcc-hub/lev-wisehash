# LEV WiseHash Marketplace

Standalone Codex marketplace for a LEV-owned adaptation of WiseHash dispatch and MCP pattern libraries.

This is deliberately a small adapter, not a new orchestration runtime.

## What Is Included

- Codex app / CLI plugin: `plugins/lev-wisehash`
- Repo-scoped skill copies: `.agents/skills`
- Cowork upload artifacts: `dist/*.skill`
- Shared templates and JSON schemas inside the plugin folder

## Skills

- `dispatch-protocol`
- `cross-model-review`
- `bounded-implementation`
- `verification-first-spec`
- `mcp-wrapper-discipline`

## Install In Codex App / CLI

From this marketplace root:

```bash
codex plugin marketplace add /Users/ant/code/lev-wisehash
```

Then restart Codex and install `lev-wisehash` from the plugin directory.

For another machine, replace the path with the cloned repo path or a Git URL once published.

## Use In Coding Repos

Copy selected folders from `.agents/skills/` into the target repo's `.agents/skills/`.

## Use In Cowork

Upload each file in `dist/` individually via Cowork Settings > Capabilities > Upload Skill.

Do not upload a combined multi-skill zip.

## Source Attribution

Inspired by and adapted from:

- https://github.com/wisehash-llc/dispatch-protocol
- https://github.com/wisehash-llc/mcp-patterns

This repo rewrites those patterns into LEV's skill/plugin conventions and hardens the MCP guidance for LEV's secret-handling and production-operation rules.

## Security Rules

- No secrets in chat, logs, docs, screenshots, `.mcp.json`, or examples.
- Generic credential examples must be rewritten before production use.
- MCP wrapper guidance is an audit/checklist layer until environment-specific review is complete.
- No production infra writes are implied by this package.
