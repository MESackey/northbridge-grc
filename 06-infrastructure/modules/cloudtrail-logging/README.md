# cloudtrail-logging module

## What it builds and which controls it supports
| Setting | ISO 27001:2022 | NIST CSF 2.0 | Risk |
|---|---|---|---|
| Multi-region trail recording AWS management actions | A.8.15 | DE.CM | R-004 (AWS level only) |
| Log file validation, so tampering with logs can be detected | A.8.15 | PR.DS | R-004 |
| Logs stored in the s3-secure bucket (private, encrypted, versioned) | A.8.15, A.8.24 | PR.DS | R-001 |

## Honest limits
- CloudTrail records actions on AWS itself. Staff viewing patient records inside the app needs the app's own audit log (planned under R-004).
- (write a second limit in your own words, for example about who reads these logs)