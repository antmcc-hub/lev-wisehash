---
name: verification-first-spec
description: "Verification-first spec contract. Use when correctness proof is harder than implementation, especially migrations, infra, MCP, concurrency, production, data integrity, or agent workflows that need acceptance checks before design prose."
---

# Verification-First Spec

## Metadata
side_effects: ["May create specs and acceptance criteria"]
trust_tier: read-write
requires_approval: false
tool_dependencies: ["filesystem optional"]
context_cost: medium

## What it does

Creates a Shape D spec where verification dominates design. The spec starts with how the work will be proven correct, then designs to satisfy that proof.

## Use when

- the work is tier 3 or close to tier 3
- hidden invariants matter more than UI polish
- a migration, MCP integration, data sync, or agent workflow could silently fail
- a later bounded implementation needs acceptance criteria fixed first
- the right answer might be "verification is infeasible"

## Do NOT use when

- the change is a small, obvious implementation following an existing pattern
- the user wants a brainstorm rather than a buildable spec
- no one can name what correctness means
- the next action would require production writes without approval

## Required Spec Shape

```markdown
# Verification-First Spec

## Decision
GO | GO-WITH-AMENDS | REJECT

## Correctness Claims
What must be true when this is done.

## Acceptance Checks
Executable checks first. Manual checks only where executable checks are impossible.

## Failure Modes
How this can fail silently, partially, expensively, or irreversibly.

## Observability / Evidence
Logs, metrics, screenshots, database rows, API responses, or audit entries that prove behavior.

## Rollback / Recovery
How to return to previous state.

## Design
Only after verification sections.

## Implementation Boundary
What later implementation may touch and what remains off-limits.

## Blocked Conditions
Missing source, unprovable invariant, secret exposure risk, production-write risk, unavailable verification, or unclear owner.
```

## LEV Discipline

- A REJECT because proof is infeasible is a successful outcome.
- Do not bury verification after design prose.
- Any Supabase, AWS, GitHub App, SSM, or production deployment detail must follow LevInfra proven patterns.
- No credentials, tokens, private keys, or `.env` values in specs.
- Quote costs in AUD when cost is part of the decision.

## Output Format

Return the spec in the required shape and lead with the GO / GO-WITH-AMENDS / REJECT decision.

## Verification
- TRIGGER_POSITIVE: "Write a verification-first spec before we touch this MCP integration."
- TRIGGER_NEGATIVE: "Make this one-line copy edit." (direct edit or normal task)
- OUTPUT_CHECK: Output puts correctness claims, acceptance checks, failure modes, and evidence before design prose.
