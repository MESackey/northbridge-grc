# Scanner findings triage (Day 21)

- **Date:** 15 November 2026
- **Sources:** Arko scan (Day 16), Checkov 3.4.3 and Trivy 0.76.2 (Day 17 and the pipeline), Semgrep 1.184.0 (pipeline, Days 19 and 20)
- **Scope:** the `northbridge-grc` repository after Day 20. Static scans of code and settings, not a deployed environment.
- **Rule used:** a scanner finding is not a risk. A risk needs an asset, a threat, a vulnerability and an owner. I grouped findings by the weakness behind them, scored each group with `methodology.md`, and linked controls. Findings with no real risk behind them were accepted or rejected, with a reason.

## 1. What happened to every finding

| # | Finding (tool and check IDs) | Decision | Where it went | Why |
|---|---|---|---|---|
| 1 | S3 access logging off (Checkov CKV_AWS_18, Trivy AWS-0089) | New risk | R-014 | Without object-level logs a breach cannot be scoped for the 72-hour ICO report |
| 2 | No customer-managed encryption keys (Checkov CKV_AWS_145, CKV_AWS_189, CKV_AWS_35; Trivy AWS-0132, AWS-0027, AWS-0015; Semgrep CMK rules) | New risk | R-015 | Provider-managed keys are on, so the gap is control and audit of keys, not missing encryption. Rated Medium after existing controls |
| 3 | MFA not enforced by policy (Trivy AWS-0123) and reuse history below benchmark (Checkov CKV_AWS_13) | New risk | R-016 | Day 18 shows MFA present today, but nothing forces it for new users |
| 4 | No lifecycle rule (Checkov CKV2_AWS_61, Arko findings 1 and 2) | New risk | R-017 | Over-retention of personal data (UK GDPR storage limitation, ISO A.8.10). Arko called it CRITICAL for cost reasons. I rate the privacy risk Medium |
| 5 | CloudTrail not sent to CloudWatch or SNS (Checkov CKV2_AWS_10, CKV_AWS_252; Trivy AWS-0162) | New risk | R-018 | Logs exist but nobody is alerted. Feeds the SIEM work on Day 22 |
| 6 | Deliberately insecure test code: public access block off, open SSH, unrestricted egress, unencrypted disk, wildcard IAM policy (`day17-scan-compare/bad`, `day20-block-demo` before the fix) | Rejected as new risks | R-001 already covers the public-bucket class | Test code, never applied to AWS. Its purpose was to prove the scanners and the pipeline block it (Days 17 and 20) |
| 7 | No cross-region replication (Checkov CKV_AWS_144) | Accepted | Covered by R-003 | Cost and data-residency. R-003 already plans multi-AZ and a tested restore. Revisit when availability requirements are set |
| 8 | No S3 event notifications (Checkov CKV2_AWS_62) | Rejected | None | No consumer for them, and they do not protect data. Detection gaps are handled by R-014 and R-018 |
| 9 | Security group not attached to anything (Checkov CKV2_AWS_5) | Rejected | None | Artefact of a test folder with no servers |
| 10 | No password expiry (Checkov CKV_AWS_9, Trivy AWS-0062) | Accepted | R-016 (MFA is the control) | NCSC advises against forcing regular password expiry |
| 11 | Arko lifecycle finding on `day10-s3-test` | Rejected | None | Test bucket, destroyed after use (Day 10) |
| 12 | Arko Hackable Score 29% and threat model | Not scored | Context only | I do not know how the score is calculated, so I do not use it as evidence |

## 2. Control mapping

| Risk | ISO/IEC 27001:2022 Annex A | NIST CSF 2.0 | Technical control to add | Evidence now |
|---|---|---|---|---|
| R-014 | A.8.15 Logging; A.5.28 Collection of evidence | DE.CM; RS.AN | Server access logging and CloudTrail data events for patient buckets | `.checkov.yaml` skip for CKV_AWS_18 (recorded as planned) |
| R-015 | A.8.24 Use of cryptography | PR.DS | Customer-managed KMS keys with rotation, for patient data only | `.checkov.yaml` and `.trivyignore` (recorded as planned) |
| R-016 | A.8.5 Secure authentication; A.8.2 Privileged access rights; A.5.17 Authentication information | PR.AA | MFA-required IAM policy on every group; reuse history 24; monthly evidence run | `evidence/day18-evidence-report.csv`, `scripts/evidence-check.py` |
| R-017 | A.8.10 Information deletion; A.5.33 Protection of records | PR.DS; GV.PO | Retention schedule and a lifecycle variable in the s3-secure module | `evidence/arko/day16-arko-notes.md` |
| R-018 | A.8.16 Monitoring activities; A.8.15 Logging | DE.CM; DE.AE | CloudTrail to CloudWatch Logs with alarms and routing | `.checkov.yaml` (recorded as planned) |

The Statement of Applicability (`03-compliance/soa.csv`) now lists these risks against A.8.5, A.8.10, A.8.15, A.8.16 and A.8.24.

## 3. A correction
`.checkov.yaml` said "IAM password reuse prevention not set". That was wrong: the `iam-baseline` module sets a history of 5, and Checkov's check expects 24. The comment is corrected in this pull request, and raising the history to 24 is part of R-016.

## 4. Limits
- The scores and ratings are my own judgement using the Northbridge methodology. Treatment dates and owners are fictional and not approved by anyone.
- The modules are tested in a lab and not deployed, so these risks describe the planned production baseline.
- Four tools found different things. A clean scan would not show the environment is secure.
- Tool IDs and versions are those listed above and may change.