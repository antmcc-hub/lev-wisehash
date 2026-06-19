# LEV WiseHash Adoption Note

## Position

LEV treats WiseHash's `dispatch-protocol` and `mcp-patterns` repos as collaboration/reference inputs, not as a runtime dependency.

Decision: **small adapter**.

Adopt the contract layer:

- dispatch packet before work starts
- mirrored return artifact after work finishes
- cross-model review discipline
- bounded implementation scope and worktree isolation
- verification-first spec shape
- MCP wrapper audit checklist

Do not create:

- a new orchestration runtime
- a WiseHash-only workflow lane
- production MCP wiring copied from generic examples

## Source Attribution

This plugin is a LEV-owned adaptation inspired by:

- https://github.com/wisehash-llc/dispatch-protocol
- https://github.com/wisehash-llc/mcp-patterns

The public WiseHash repos are Apache-2.0 pattern libraries. This LEV plugin rewrites the patterns into LEV's skill format and applies LEV-specific security and operating rules.

## Security Posture

LEV rules override generic examples:

- Never fetch or expose secrets in chat.
- Never put token values in `.mcp.json`, docs, logs, screenshots, or examples.
- AWS Secrets Manager reads must use the redirected shell pattern documented in LevInfra `proven-patterns.md`.
- SSM is the only EC2 operations path.
- Wrapper examples are design checklists until reviewed for the target environment.
- Stdio-over-SSH is not a default LEV pattern because it can bypass established SSM/CI/CD boundaries.

## Trial Gate

Promote this beyond adapter status only after three real non-production runs show one of:

- less re-explanation before delegation
- fewer ambiguous review results
- earlier detection of scope drift
- clearer verification evidence
- safer MCP wrapper decisions
