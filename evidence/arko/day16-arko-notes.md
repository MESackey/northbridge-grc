# Day 16: Arko scan (DevSecAI)

- **Date:** 28 October 2026
- **Tool:** Arko by DevSecAI, VS Code extension v1.0.26, Free plan, engine "Arko Core + Anthropic"
- **Scope:** whole `northbridge-grc` repository (Terraform modules and test folders, policies, docs), branch `day16-arko-scan`
- **Method:** Run Scan clicked once. No fixes applied and no findings ignored.

## Result
- Hackable Score: 29% (Arko's own label: "Low Risk"). I do not know how Arko calculates the score, so I record it as the tool's own measure.
- Open issues: 2, both rated CRITICAL by Arko
- Threat model summary shown by Arko: 4 severe, 5 potential risks. Only the summary counts and diagram were reviewed.
- Application summary: 2 technologies, 4 data flows, 3 targets

## Findings
| # | Arko severity | Finding | Location | What Arko says | My assessment |
|---|---|---|---|---|---|
| 1 | CRITICAL | S3 bucket without a lifecycle policy | `06-infrastructure/day10-s3-test/main.tf` line 15 | "Could increase avoidable operating costs" | Severity overstated. Cost and housekeeping only. Lab test bucket, destroyed after testing, never deployed. Accepted, no action. |
| 2 | CRITICAL | S3 bucket without a lifecycle policy | `06-infrastructure/modules/s3-secure/main.tf` line 20 | "Could increase avoidable operating costs" | Valid improvement, severity overstated. With versioning on, old versions are kept forever (cost, and retention of patient data, ISO 27001 A.8.10). Retention period is a business decision, so no default in the module. Planned: optional lifecycle variable. Not changed today. |

Arko also lists "Hygiene & cost (2), non-security": s3 bucket without a lifecycle policy x2

## Threat model observations
- Nodes shown: Auditor (AWS IAM, SecurityAudit permissions) -> read-only API calls -> Cloud Provider APIs; Infrastructure Engineer; Development Environment; Cloud Backend Storage.
- It was built from the Terraform only. It does not show the patient scheduling data, the ML triage feature or the vendors, because those exist only as documents.

## What this scan did not find
No public bucket, missing encryption or hard-coded secret was flagged in the scanned files.

## Limits (be honest about these)
- One AI-assisted scan of repository files only. Nothing deployed in AWS was scanned.
- Arko's severity labels are not calibrated to the Northbridge risk register.
- The free plan cannot open the detailed finding pages (Arko Control Plane).
- Not a replacement for Checkov and Trivy, which we run on Day 17.

## Evidence
- `day16-arko-score.png`
- `day16-arko-threat-model.png`
- `day16-arko-findings.png`