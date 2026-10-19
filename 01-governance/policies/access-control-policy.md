# Access control policy: Northbridge Health Ltd

| Field | Value |
|---|---|
| Version | 0.1 (draft) |
| Policy owner | Head of Security and Compliance |
| Approved by | CEO (fictional) |
| Effective date | 18 October 2026 |
| Next review | 18 October 2027 |

## 1. Purpose
Limit access to Northbridge systems and patient data to people who need it, and remove it when they no longer do.

## 2. Scope
All employees, contractors and third parties who access Northbridge systems, cloud accounts (AWS, GitHub, Google Workspace) or patient data.

## 3. Policy statements
1. **Least privilege.** Access is granted at the minimum level a person's role needs (need to know).
2. **Unique accounts.** Every user has their own account. Shared accounts are prohibited.
3. **Multi-factor authentication (MFA).** MFA is mandatory for all user accounts without exception. All staff accounts must enforce phishing-resistant authentication (WebAuthn/FIDO2 hardware keys or passkeys). Standard SMS/TOTP push notifications are prohibited.
4. **Approval.** Access to patient data needs written approval from the user's line manager and the system owner.
5. **Joiners, movers and leavers.** Access is granted on the start date, updated within 24 hours of a role change, and removed immediately upon notification, but no later than 1 hour post-departure (or immediately/prior to notification for involuntary terminations).
6. **Access reviews.** System owners perform user access reviews (UARs) bi-monthly (every 60 days) for patient data systems and administrative roles. Reviews are documented, approved by the asset owner, and retained for audit evidence.
7. **Privileged access.** Administrator accounts are separate from day-to-day accounts and used only for administration.
8. **Logging and monitoring.** Access to patient records is logged, and logs are reviewed for unusual access.
9. **Exceptions.** Exceptions must be formally documented with a mandatory expiration date (max 90 days), compensate with mitigating controls, and receive written approval from the Head of Security and Compliance. Exceptions introducing High or Critical residual risk require joint approval from the Head of Security and Compliance and the CEO.

## 4. Roles
| Role | Responsibility |
|---|---|
| CEO | Approves the policy and High or Critical exceptions |
| CTO | Implements technical access controls (first line) |
| Line managers | Approve access requests and report leavers |
| Head of Security and Compliance | Owns the policy and monitors compliance (second line) |

## 5. Enforcement
Breaches of this policy may lead to disciplinary action.

## 6. Mapping and related risks
- ISO/IEC 27001:2022: A.5.15, A.5.16, A.5.18, A.8.2, A.8.3, A.8.5, A.8.15
- NIST CSF 2.0: GV.PO, PR.AA
- Related risks (see 02-risk/register.csv): R-002, R-004