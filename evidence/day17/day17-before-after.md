# Day 17: Checkov and Trivy side by side

- **Date:** 10 November 2026
- **Tools:** Checkov 3.4.3 and Trivy 0.76.2 (`trivy config`), default rules, no custom policies
- **Test code:** `06-infrastructure/day17-scan-compare/bad` (deliberately insecure) and `good` (remediated). Neither was ever applied to AWS.
- **Raw output:** `checkov-bad.txt`, `checkov-good.txt`, `trivy-bad.txt`, `trivy-good.txt` in this folder.

## Headline numbers

| Folder | Checkov passed | Checkov failed | Trivy failures | Trivy by severity |
|---|---|---|---|---|
| bad | 9 | 26 | 14 | 1 critical, 7 high, 1 medium, 5 low |
| good | 30 | 6 | 3 | 1 high, 2 low |

Raw counts are not comparable: one weakness can trigger many checks (Checkov raised 9 checks for one wildcard IAM policy). The tables below group results by weakness.

## Same weakness, both tools

| Weakness | Checkov | Trivy | ISO 27001:2022 Annex A (my mapping) | Owner to fix | In good/ |
|---|---|---|---|---|---|
| S3 public access block switched off | CKV_AWS_53, 54, 55, 56, CKV2_AWS_6 | AWS-0086, 0087, 0091, 0093 (all HIGH) | A.8.3 Information access restriction | Cloud engineer | Fixed |
| S3 versioning off | CKV_AWS_21 | AWS-0090 (MEDIUM) | A.8.13 Information backup | Cloud engineer | Fixed |
| SSH open to the internet | CKV_AWS_24 | AWS-0107 (HIGH) | A.8.20 Networks security | Cloud engineer | Fixed (internal range only) |
| Unrestricted outbound traffic | CKV_AWS_382 | AWS-0104 (CRITICAL) | A.8.20 Networks security | Cloud engineer | Fixed |
| Security group descriptions missing | CKV_AWS_23 | AWS-0099, AWS-0124 x2 (LOW) | A.8.9 Configuration management | Cloud engineer | Fixed |
| EBS volume unencrypted | CKV_AWS_3 | AWS-0026 (HIGH) | A.8.24 Use of cryptography | Cloud engineer | Fixed |
| S3 access logging off | CKV_AWS_18 | AWS-0089 (LOW) | A.8.15 Logging | Cloud engineer | Not fixed (see decisions) |
| S3 not encrypted with a customer-managed key | CKV_AWS_145 | AWS-0132 (HIGH) | A.8.24 Use of cryptography | Cloud engineer | Not fixed (see decisions) |
| EBS not using a customer-managed key | CKV_AWS_189 | AWS-0027 (LOW) | A.8.24 Use of cryptography | Cloud engineer | Not fixed (see decisions) |

## Found by only one tool

| Weakness | Found by | Check | ISO 27001:2022 Annex A (my mapping) | In good/ |
|---|---|---|---|---|
| Wildcard IAM policy (Action `*` on Resource `*`), 9 checks | Checkov only | CKV_AWS_62, 63, 286, 287, 288, 289, 290, 355, CKV2_AWS_40 | A.8.2 Privileged access rights, A.5.15 Access control | Fixed (read-only, one bucket) |
| No lifecycle rule on the bucket | Checkov only | CKV2_AWS_61 | A.8.10 Information deletion | Fixed (same issue Arko rated CRITICAL on Day 16) |
| No cross-region replication | Checkov only | CKV_AWS_144 | A.8.14 Redundancy | Not fixed (see decisions) |
| No event notifications | Checkov only | CKV2_AWS_62 | A.8.16 Monitoring activities | Not fixed (see decisions) |
| Security group not attached to anything | Checkov only | CKV2_AWS_5 | None: artefact of the test | Not fixed (see decisions) |

Trivy reported nothing for the wildcard IAM policy in this test. I have not investigated why, so I do not conclude that Trivy cannot find such policies.

## What good/ still fails, and my decision

| Finding | Decision | Reason |
|---|---|---|
| S3 access logging (CKV_AWS_18, AWS-0089) | Planned | Needed for A.8.15. Add a separate log bucket to the s3-secure module. |
| Customer-managed keys for S3 and EBS (CKV_AWS_145, AWS-0132, CKV_AWS_189, AWS-0027) | Planned for patient-data only | Provider-managed encryption is already on. Customer-managed keys add control, rotation and audit, which is justified for patient data but costly for lower classes. |
| Cross-region replication (CKV_AWS_144) | Accepted | Cost, and the destination region must respect data residency. Decide when availability requirements are set. |
| Event notifications (CKV2_AWS_62) | Accepted | No downstream consumer for this bucket. |
| Unattached security group (CKV2_AWS_5) | Rejected | Artefact of a test folder with no servers. |

## Takeaways

- Neither tool found everything. The overlap is partial, so run both.
- Trivy ranks findings by severity. Checkov's free output shows pass or fail only.
- A clean-looking scan is not proof of security: good/ still fails 6 and 3 checks, and each one is a decision someone has to own.
- The owner column shows who would fix each item in a real company. The GRC job is deciding which findings to fix, accept or reject, and recording why.

## Limits

- Static scan of two small files, not a deployed environment.
- Default rules only, no custom policies, at the versions above.
- The Annex A mapping is my own judgement.