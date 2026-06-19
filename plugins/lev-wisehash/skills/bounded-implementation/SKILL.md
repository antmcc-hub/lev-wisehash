---
name: bounded-implementation
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
      reasoning: medium
  compatibility: both
description: "Bounded implementation contract. Use before or during scoped implementation where an agent may edit files only inside named boundaries, with off-limits scope, worktree isolation rules, verification, and halt markers."
---

# Bounded Implementation

## Metadata
side_effects: ["May create implementation contracts and verification checklists"]
trust_tier: mutating
requires_approval: false
tool_dependencies: ["filesystem", "git optional"]
context_cost: medium

## What it does

Turns a build request into a Shape C bounded implementation packet.

It defines what may be touched, what is off-limits, what existing pattern should be followed, how to verify the change, and when the implementer must halt instead of widening scope.

## Use when

- a code or artifact change follows an existing pattern
- file scope can be named
- the change is reversible
- the agent should implement but not redesign
- parallel work may need worktree isolation

## Do NOT use when

- the change touches production state, credentials, deploys, payments, or irreversible data
- the pattern does not exist yet
- architecture is still undecided
- the file scope cannot be stated
- two agents would edit the same files in parallel

## Required Contract

```markdown
# Bounded Implementation Contract

## Goal

## Existing Pattern To Follow

## Allowed Files / Areas

## Off-Limits Files / Areas

## Explicit Non-Goals

## Worktree Rule
Sequential single-writer | isolated worktree required | read-only only

## Verification
Commands, manual checks, screenshots, or evidence required.

## Blocked Conditions
Halt on scope creep, missing pattern, dependency mismatch, secret exposure risk, production-write risk, test impossibility, or discovered tier-3 work.

## Return Artifact
Use dispatch result with GO / GO-WITH-AMENDS / REJECT.
```

## Worktree Isolation Rule

Use a separate worktree or separate checkout when:

- two or more writers mutate the same repo concurrently
- a shape E parallel track is running
- generated artifacts or broad formatting can collide

Do not use worktree isolation as a substitute for non-overlap. Parallel tracks still need independent files or state.

## Implementation Discipline

- Read repo instructions before editing.
- Preserve unrelated dirty changes.
- Do not widen scope because an adjacent issue is visible.
- If a verification command is unavailable, report it clearly.
- If tier-3 work appears, stop and return a REJECT or BLOCKED result.

## Output Format

Lead with the contract before implementation when planning. After implementation, lead with:

```markdown
# Bounded Implementation Result
Verdict: GO | GO-WITH-AMENDS | REJECT
Confidence:
Files touched:
Verification:
Required amends:
Blocked conditions:
```

## Verification
- TRIGGER_POSITIVE: "Prepare a bounded implementation packet for another agent to add this page."
- TRIGGER_NEGATIVE: "Design the architecture for this new production integration." (should route to verification-first-spec or implementation-planner)
- OUTPUT_CHECK: Output names allowed files, off-limits files, non-goals, blocked conditions, and verification evidence.
