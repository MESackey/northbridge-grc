# Asset register and CMDB

- asset-register.csv: what Northbridge must protect, who owns it, how sensitive it is.
- cmdb-relationships.md: how those assets connect.

## Source of truth
- Cloud assets built with Terraform: their tags (Owner, DataClassification, Environment, ManagedBy). The tags are required by the s3-secure module.
- Everything else: maintained by hand and reviewed quarterly by the asset owner.

## Controls this supports
ISO 27001:2022 A.5.9 (inventory), A.5.11 (return of assets), A.5.12 (classification). NIST CSF 2.0 ID.AM.