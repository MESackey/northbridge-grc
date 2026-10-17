# Risk management methodology: Northbridge Health Ltd

**Version:** 0.1 (draft)
**Owner:** Head of Security and Compliance
**Approved by:** CEO (fictional)
**Review cycle:** Annually, and after any major incident or change

## 1. Purpose
This document explains how Northbridge identifies, scores, treats and monitors information security risks.
It supports ISO/IEC 27001:2022 clauses 6.1.2 and 6.1.3 and follows the approach in NIST SP 800-30 Rev. 1.

## 2. Scope
All risks to the confidentiality, integrity and availability of information within the ISMS scope (see 01-governance/isms-scope.md).

## 3. Roles
| Role | Responsibility |
|---|---|
| CEO | Accepts High and Critical risks. Sets risk appetite |
| CTO | Owns technical risks. Delivers treatment plans (first line) |
| Head of Security and Compliance | Runs the process, challenges scores, reports (second line) |
| Risk owner | The named person accountable for a specific risk |
| Internal audit | Independently checks the process works (third line) |

## 4. Process
1. **Identify:** list assets, then threats and vulnerabilities for each
2. **Analyse:** score likelihood and impact (inherent risk)
3. **Evaluate:** compare with risk appetite (section 7)
4. **Treat:** choose mitigate, accept, transfer or avoid
5. **Re-score:** record residual risk after controls
6. **Monitor:** review on a schedule (section 8)

## 5. Likelihood scale
| Score | Level | Meaning |
|---|---|---|
| 1 | Rare | Unlikely in the next 3 years |
| 2 | Unlikely | Could happen once in 2-3 years |
| 3 | Possible | Could happen once a year |
| 4 | Likely | Could happen several times a year |
| 5 | Almost certain | Expected monthly or already happening |

## 6. Impact scale
| Score | Level | Meaning |
|---|---|---|
| 1 | Negligible | No customer impact. Minor internal inconvenience |
| 2 | Minor | Short disruption. No personal data affected |
| 3 | Moderate | Limited personal data exposure, or service down for hours. Customer complaints |
| 4 | Major | Significant personal data breach reportable to the ICO, or service down for days. Contract penalties |
| 5 | Severe | Large-scale special category data breach, regulatory action, loss of key customers |

**Risk score = Likelihood x Impact.**

## 7. Risk ratings and appetite
| Score | Rating | Required action | Who decides |
|---|---|---|---|
| 1-4 | Low | Accept or monitor | Risk owner |
| 5-9 | Medium | Treatment plan within 90 days | Risk owner, informed to Head of Security and Compliance |
| 10-16 | High | Treatment plan within 30 days | CTO, reported to CEO |
| 20-25 | Critical | Immediate action and escalation | CEO |

**Risk appetite statement:** Northbridge has a low appetite for risks to patient data and a moderate appetite for risks to internal tooling.
No risk rated High or Critical may be accepted without written CEO approval.

## 8. Monitoring and review
| Rating | Review frequency |
|---|---|
| Critical | Monthly |
| High | Quarterly |
| Medium | Every 6 months |
| Low | Annually |

## 9. Worked example
| Field | Value |
|---|---|
| Risk | Patient exports stored in a publicly readable cloud storage bucket |
| Asset | Patient appointment data |
| Threat | External attacker scanning for open storage |
| Vulnerability | Misconfigured bucket permissions |
| Inherent likelihood / impact | 4 x 5 = 20 (Critical) |
| Controls | Block public access policy, encryption, pipeline check on infrastructure code |
| Residual likelihood / impact | 1 x 5 = 5 (Medium) |
| Treatment | Mitigate |
| Risk owner | CTO |
### Example 2: Cloud access key committed to GitHub

| Field | Value |
|---|---|
| Risk | A developer accidentally commits an AWS acces key to a GitHub repository, letting an attacker reach the cloud environment |
| Asset | AWS production account and the patient data it holds |
| Threat | Automated bots and external attackers scanning GitHub for exposed credentials |
| Vulnerability | Long-lived access keys and no automatic check for secrets before code is merged |
| Inherent likelihood / impact | 3 x 4 = 12 (High) |
| Controls | Secret scanning in the pipeline (Gitleaks), GitHub push protection, short-lived credentials through single sign-on, least-privilege roles, MFA |
| Residual likelihood / impact | 1 x 3 = 3 (Low) |
| Treatment | Mitigate |
| Risk owner | CTO |

## 10. References
- ISO/IEC 27001:2022, clauses 6.1.2 and 6.1.3
- NIST SP 800-30 Rev. 1, Guide for Conducting Risk Assessments
- NCSC risk management guidance