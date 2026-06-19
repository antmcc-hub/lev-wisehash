---
name: cross-model-review
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
description: "Cross-model review contract. Use when a load-bearing spec, PR, plan, agent output, or architecture decision should be reviewed by an independent model family with verdict, confidence, evidence, and required amends."
---

# Cross-Model Review

## Metadata
side_effects: ["May produce review findings and required amendments"]
trust_tier: read-only
requires_approval: false
tool_dependencies: ["filesystem optional", "git optional"]
context_cost: medium

## What it does

Runs a Shape B cross-model peer review: one model or agent authors, a different model family reviews independently against the same source material.

The point is not tone-polishing. The point is to catch single-model drift, missing assumptions, source mismatch, and unverified claims before the artifact becomes load-bearing.

## Use when

- a spec will drive implementation
- a PR or diff may merge
- an architecture decision will constrain later work
- an agent result looks plausible but needs independent evidence
- the artifact should show Papi/Ankit/LEV collaborators what was checked and why

## Do NOT use when

- no primary sources are available to review
- the user wants the reviewer to rewrite instead of review
- the task is a normal code review already covered by `pr-review-lev`
- secrets would need to be fetched or displayed

## Review Packet

Require:

- artifact under review
- primary sources the artifact depends on
- author/model family if known
- reviewer/model family if known
- explicit review axes
- required verification commands or explanation that none exist
- blocked conditions

## Review Axes

Default axes:

- source fidelity
- hidden assumptions
- scope drift
- missing edge cases
- verification gap
- security and secret exposure
- operational blast radius
- user-facing/regression risk

## Output Format

```markdown
# Cross-Model Review
Verdict: GO | GO-WITH-AMENDS | REJECT
Confidence: High | Medium | Low, with basis
Reviewer Independence: different model family | same-family lower coverage | unknown

## Findings
1. [Severity] Finding
   Evidence:
   Required amend:

## Required Amends
1.

## Verification Evidence
- Sources read:
- Commands/checks run:
- Checks not run and why:

## Halt Markers Fired
- None | list

## Merge/Proceed Gate
Clear statement of what must happen before proceeding.
```

## Review Discipline

- A clean GO must explain what was checked, not just say no issues found.
- GO-WITH-AMENDS means the amends are required.
- REJECT must name what would have to change for a re-dispatch.
- Same-family review is lower coverage and must be labelled that way.
- Review findings must cite evidence; unsupported suspicion goes under open questions.

## Verification
- TRIGGER_POSITIVE: "Run a cross-model review on this implementation spec before I build it."
- TRIGGER_NEGATIVE: "Implement this bounded code change." (should route to bounded-implementation or normal coding)
- OUTPUT_CHECK: Output leads with GO / GO-WITH-AMENDS / REJECT, confidence, findings, required amends, and verification evidence.
