# LEV MCP Wrapper Audit

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
