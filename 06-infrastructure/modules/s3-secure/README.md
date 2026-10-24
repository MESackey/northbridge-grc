# s3-secure module

Creates an S3 bucket with the baseline controls Northbridge requires.

## What it builds and which controls it supports
| Setting | ISO 27001:2022 | NIST CSF 2.0 | Risk |
|---|---|---|---|
| Block all public access | A.8.3, A.8.9 | PR.DS | R-001 |
| Encryption at rest (SSE-S3) | A.8.24 | PR.DS | R-001, R-009 |
| Versioning (recover from deletion or overwrite) | A.8.13 | PR.DS, RC.RP | R-003 |
| Required tags: Owner, DataClassification, Environment | A.5.9, A.5.12 | ID.AM | none direct |

## Inputs
- bucket_prefix: start of the bucket name
- owner: accountable role
- data_classification: public, internal, confidential or patient-data
- environment: default "lab"

## Honest limits
- **No Automated Log Retention or Archiving:** This module provisions s3 bucket access logging for audit visibility, but it does not configure automated lifecycle policies, long-term archiving to AWS Glacier.  
- **No Built-in Public Access Override Protection:** While the module sets bucket-level 'BlockPublicAccess' configuration upon creation, it does not deploy active AWS Config rules or automated remediation pipelines to prevent manual policy overrides post-deployment. 