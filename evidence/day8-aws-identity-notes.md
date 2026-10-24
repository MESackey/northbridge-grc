# Day 8: AWS identity hygiene

## What I checked
- Root account: MFA enabled.
- IAM users: grc-admin (everyday admin) and CLIusage1 (old CLI user).
- Budget: monthly zero-spend budget, alert goes to my verified email.

## Findings and fixes
| Finding | Fix | Evidence |
|---|---|---|
| grc-admin had no MFA | Assigned a virtual MFA device | day8-aws-mfa-assigned.jpg |
| CLIusage1 access key unused for 589 days | Key deactivated (then deleted) | day8-aws-stale-key-inactive.png |
| Console password for grc-admin unknown | Reset by the root account | n/a |

## Honest limits
- grc-admin has AdministratorAccess. For a single-person lab this is acceptable;
  in a company I would use narrower roles (least privilege, ISO 27001 A.8.2).
- Root is now kept for emergencies only.

## Controls this supports
ISO 27001:2022 A.5.15, A.5.16, A.5.18, A.8.2, A.8.5. NIST CSF 2.0 PR.AA.