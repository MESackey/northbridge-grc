# iam-baseline module

## What it builds and which controls it supports
| Setting | ISO 27001:2022 | NIST CSF 2.0 | Risk |
|---|---|---|---|
| Password policy: 14+ characters, mixed types, no reuse of last 5 | A.5.17 | PR.AA | R-002 |
| Group-based access instead of per-person permissions | A.5.15, A.5.18 | PR.AA | R-004 |
| Read-only auditors group (AWS SecurityAudit policy) | A.5.15, A.5.18, A.8.2 | PR.AA, GV.OV | R-004 |

The auditors group lets the third line (outsourced internal audit) inspect configuration without being able to change anything.

## Honest limits
- (write one limit in your own words, for example what a password policy does not stop)
- (write a second limit in your own words)