---
name: mcp-wrapper-discipline
metadata:
  version: "0.1"
  phase: P12
  chain: standalone
  status: live
  type: lev
  load_bearing: false
  model_routing:
    anthropic:
      tier: sonnet
      model: claude-sonnet-4-6
    openai:
      tier: gpt-5.4
      model: gpt-5.4
      reasoning: high
  compatibility: both
description: "LEV-hardened MCP wrapper audit. Use before adopting, writing, or changing MCP wrappers, credential resolution, stdio/HTTP transport, per-agent identity, cross-host state access, or no-hot-reload operational notes."
---

# MCP Wrapper Discipline

## Metadata
side_effects: ["May produce MCP wrapper audit findings and adoption gates"]
trust_tier: read-only
requires_approval: false
tool_dependencies: ["filesystem optional"]
context_cost: medium

## What it does

Runs a LEV-hardened audit of MCP wrapper and credential patterns inspired by WiseHash `mcp-patterns`.

It decides whether an MCP design should use HTTP-native transport, stdio-local wrapper, explicitly approved remote stdio, or reject an unnecessary bridge. It also checks credentials, identity, canonical state, reload behavior, and logging.

## Use when

- adding or changing an MCP server
- reviewing `.mcp.json`
- designing a wrapper script
- deciding between HTTP-native and stdio transport
- considering remote/cross-host MCP access
- adding per-agent or per-tenant credentials
- debugging "tool not updated" after a wrapper/schema change

## Do NOT use when

- the user only wants to call an already configured tool
- the design would fetch or print secrets
- the request asks to bypass LEV's SSM/CI/CD production boundaries
- the server is already governed by a more specific production runbook

## LEV Non-Negotiables

- No token values in `.mcp.json`.
- No secret values in chat, logs, screenshots, README examples, or shell output.
- Never fetch AWS Secrets Manager values through tools that print values into chat.
- Use redirected shell patterns for secret reads when secret use is explicitly approved.
- EC2 operations go through SSM or Git/CI/CD, not direct file edits.
- HTTP-native MCP should stay HTTP-native unless there is a real operational reason to bridge.
- Wrapper and `.mcp.json` changes require a new agent session or restart before they take effect.

## Audit Checklist

```markdown
# MCP Wrapper Audit

## Verdict
GO | GO-WITH-AMENDS | REJECT

## Transport Decision
HTTP-native | stdio-local | stdio-over-approved-remote | reject bridge

## Credential Chain
Where credentials are resolved, how misses fail, and how logs avoid values.

## Identity Attribution
Which agent or tenant identity is attached to each action.

## Runtime Boundary
Where canonical state lives and whether the wrapper duplicates or tunnels state.

## Reload Rule
What restart/new-session action is required after wrapper, MCP config, or tool schema changes.

## LEV Security Checks
- No secret values in config
- No secrets in stdout/stderr
- No production writes without approval
- No EC2 direct edits
- No generic examples copied without hardening

## Required Amends
Numbered list before adoption.
```

## Transport Decision Rules

- Prefer HTTP-native when the client and server support HTTP transport directly.
- Use stdio-local wrapper for local servers that need environment bootstrap and credential resolution at launch.
- Consider stdio-over-remote only when canonical state truly lives elsewhere and LEV security/ops boundaries approve it.
- Reject HTTP-to-stdio bridging when it only adds a dependency, process, and credential surface for cosmetic uniformity.

## Credential Chain Rules

The design must answer:

- What is the credential name or alias, without the value?
- Where is the canonical secret store?
- How is the store accessed without exposing values?
- What is the fallback, if any?
- Does missing credential fail loud before the server starts?
- Does every miss log only the cipher/alias name, never the value?

## Output Format

Lead with verdict and required amends. Treat unresolved credential or production-boundary questions as REJECT or GO-WITH-AMENDS, not as TODOs hidden in prose.

## Verification
- TRIGGER_POSITIVE: "Audit this MCP wrapper design before we adopt it."
- TRIGGER_NEGATIVE: "Use the GitHub tool to list open PRs." (tool usage, not wrapper design)
- OUTPUT_CHECK: Output includes transport decision, credential chain, identity attribution, runtime boundary, reload rule, LEV security checks, and verdict.
