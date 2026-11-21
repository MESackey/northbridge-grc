# Interview stories (STAR format)

How to use this file: read each story aloud and change the wording until it sounds like you. Every claim must point to evidence in this repo. If you cannot show it, cut it.

## How to build a STAR story

| Letter | Question to ask | Keep it to |
|---|---|---|
| **S**ituation | What was the setup, and what was at risk or wrong? | 2 sentences. Name the risk in plain words |
| **T**ask | What were *you* responsible for achieving? | 1 sentence. Include "prove" or "show" if evidence mattered |
| **A**ction | What did *you* do, in order? | 3 or 4 steps naming tools, plus one decision with its reason |
| **R**esult | What happened, what is the evidence, and what is the honest limit? | What the evidence showed, what changed afterwards, and one limit |

Rules:
- Say "I", not "we".
- Use only facts you can show. No numbers you cannot back up.
- End on the result and one honest limit.
- About 60 to 90 seconds spoken.

## Story 1: Blocking insecure infrastructure code (Days 19 to 21)

**Situation.** In my GRC portfolio I built a simulated UK health company, Northbridge, whose cloud setup is written as code. Nothing checked that code before it was merged, and one deliberately insecure test file had already been merged because nothing was scanning. My risk register already had a Critical risk for exactly this: patient data exposed through a misconfigured storage bucket.

**Task.** My job was to make sure insecure infrastructure code could not reach the main branch, and to prove it with evidence.

**Action.** I built a pipeline that runs four scanners on every pull request: Gitleaks for secrets, plus Semgrep, Checkov and Trivy. I pinned every third-party action to a fixed commit, because the Trivy action was compromised in March 2026. On its first run the pipeline flagged my own Dependabot settings, and I fixed that. I recorded the findings I accepted, with a reason for each. Then I made the four checks mandatory with a branch rule that even I, as the owner, cannot bypass. To test it, I opened a pull request with two deliberate flaws: SSH open to the whole internet and an unencrypted disk.

**Result.** Three of the four scanners failed it, and the merge button was disabled, so I could not merge. I fixed both flaws, all the checks went green, and then it merged. I kept screenshots as evidence, and the next day I moved the scanner findings into the risk register as five new risks. It is a lab and a one-person repo, so I set required approvals to zero. On a team I would require a reviewer.

**Short version (about 60 seconds).** Drop the Dependabot sentence and the commit-pinning sentence. Say them only if asked.

**Evidence to point to**
- `.github/workflows/security.yml`: the four scanners
- `evidence/day20/day20-pr-blocked.png`: failing required checks and the disabled merge button
- `evidence/day20/day20-checkov-failure.png`, `day20-trivy-failure.png`, `day20-semgrep-failure.png`: what each scanner found
- `evidence/day20/day20-pr-fixed.png`: all checks green after the fix
- `02-risk/scanner-findings-triage.md` and `02-risk/register.csv` (R-014 to R-018): findings turned into risks

**Likely follow-up questions**
- *Why make the checks required instead of just running them?* A check that can be ignored is not a control. The rule makes merging impossible unless they pass.
- *Why did you accept some findings?* Each one has a recorded reason in `.checkov.yaml`, `.trivyignore` and the triage file, and the real risks became R-014 to R-018.
- *What would you change on a team?* Require at least one reviewer, turn on code-owner review so changes to pipeline files need the security owner, and allow bypass only for emergencies, with an audit trail.

**Honest limits.** Lab environment. One-person repo. The Terraform modules are tested but not deployed. Static scans only.

## Template for the next story

**Situation.**

**Task.**

**Action.**

**Result.**

**Evidence to point to**

**Likely follow-up questions**

**Honest limits.**