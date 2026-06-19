---
name: dispatch-protocol
description: "WiseHash-inspired LEV dispatch contract. Use before delegating work to another agent, model, thread, worktree, or reviewer when the run needs a brief, shape choice, quality bar, blocked conditions, and mirrored result artifact."
---

# Dispatch Protocol

## Metadata
side_effects: ["May create dispatch briefs, review packets, and result templates"]
trust_tier: read-write
requires_approval: false
tool_dependencies: ["filesystem optional"]
context_cost: medium

## What it does

Creates a LEV dispatch packet before agent work starts and a mirrored return artifact for the result.

Adapted from WiseHash's public `dispatch-protocol` pattern library, upgraded to LEV/Codex/Cowork standards:

- no new runtime
- no WiseHash-only lane
- no production or secret access by default
- explicit shape, scope, output, quality bar, and blocked conditions
- explicit result verdict, confidence, findings, required amends, verification evidence, and halt markers

## Use when

Use before sending work to another agent, Codex thread, Cowork worker, human reviewer, or isolated worktree.

Use especially when:

- a task could drift without tight scope
- multiple agents or models are involved
- a result needs evidence rather than a loose summary
- work must halt instead of guessing through missing context
- the operator needs a reusable contract to show a collaborator

## Do NOT use when

- the user only asks for a quick direct answer
- the work is already fully specified and no delegation/review is happening
- the goal is to create a new orchestration runtime
- the requested action would fetch or expose secrets
- the task needs production writes without explicit approval

## Dispatch Shapes

Choose exactly one:

| Shape | Name | Use when | Result family |
|---|---|---|---|
| A | Independent verification audit | A peer reads sources and checks whether an artifact holds up. | PASS / PASS-WITH-CONCERNS / FAIL |
| B | Cross-model peer review | A different model family reviews a load-bearing artifact. | GO / GO-WITH-AMENDS / REJECT |
| C | Bounded implementation | The peer implements inside named tier-2 scope. | GO / GO-WITH-AMENDS / REJECT |
| D | Verification-first spec | The peer writes a spec where proof is harder than code. | GO / GO-WITH-AMENDS / REJECT |
| E | Parallel independent tracks | Non-overlapping work runs in isolated tracks. | Per-track GO / GO-WITH-AMENDS / REJECT plus integration verdict |

## Scope Tiers

- Tier 1: read and propose only.
- Tier 2: bounded implementation in named files or artifacts.
- Tier 3: architecture, production, credentials, money, live customer state, deploys, or irreversible operations. Write the spec or recommendation, then wait.

## Required Dispatch Brief

```markdown
# Dispatch Brief

## Shape
A independent audit | B cross-model review | C bounded implementation | D verification-first spec | E parallel independent tracks

## Variant
subprocess | fork-within-harness | separate thread | cross-host, if explicitly approved

## Profile
Target model/tool profile and reasoning effort.

## Source
Exact paths, URLs, commits, screenshots, or source records to read. Include all primary sources.

## Scope
Tier 1 read/propose | Tier 2 bounded code | Tier 3 propose/wait.

Allowed:

Off limits:

## Output
Destination path or response format.

## Quality Bar
Required checks, evidence format, citations, and confidence basis.

## Blocked Conditions
Halt and report on missing source, scope ambiguity, secret exposure risk, production-write risk, sandbox boundary, dependency mismatch, or verification impossibility.

## Context
Why this work matters and what the peer needs to know cold.

## Tasks
Ordered task list.

## Return Artifact Required
Use the Dispatch Result structure.
```

## Required Dispatch Result

```markdown
# Dispatch Result

## Verdict
PASS | PASS-WITH-CONCERNS | FAIL for audits.

GO | GO-WITH-AMENDS | REJECT for reviews, builds, specs, and parallel tracks.

## Confidence
High | Medium | Low, with basis.

## Findings
Each finding must include severity, evidence, source citation, and why it matters.

## Required Amends
Numbered list. Empty only on clean PASS or GO.

## Verification Evidence
Commands, checks, source reads, screenshots, or explicit note that no executable check was available.

## Halt Markers Fired
List every blocked condition encountered.

## Scope Discipline
State whether work stayed inside the brief.

## Follow-Up
Only include follow-up work that is outside the current authority.
```

## LEV Discipline

- Worktree isolation is required for parallel mutating repo work.
- Any production, credential, deploy, external-write, or EC2 operation is tier 3 unless explicitly approved.
- Missing source is a halt marker, not an invitation to infer.
- Verification evidence must be named before the peer starts where possible.
- GO-WITH-AMENDS means the required amends must be integrated before the run is treated as done, unless they require new authority.

## Output Format

Return the dispatch brief first. If asked to review a result, return the dispatch result with verdict and required amends first.

## Verification
- TRIGGER_POSITIVE: "Create a dispatch packet before I send this to another Codex thread."
- TRIGGER_NEGATIVE: "Summarise this short note." (direct answer, no delegation)
- OUTPUT_CHECK: Output includes shape, variant, profile, source, scope, output, quality bar, blocked conditions, and result artifact requirements.
