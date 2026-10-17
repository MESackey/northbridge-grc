# ISMS scope: Northbridge Health Ltd (draft v0.1)

> An ISMS (Information Security Management System) is the set of policies, processes and controls used to manage information security.
> ISO 27001 clause 4.3 requires you to define its scope.

## 1. Purpose
State what the ISMS protects and why.

## 2. In scope
- **Services:** the appointment scheduling platform and its ML triage feature
- **People:** all employees and contractors
- **Locations:** London office and remote working
- **Technology:** AWS production and staging accounts, GitHub organisation, corporate laptops, Google Workspace, Slack
- **Data:** patient personal data and special category data, customer configuration data, internal business data

## 3. Out of scope (with reasons)
| Item | Reason |
|---|---|
| Customers' own clinic IT systems | Managed by customers (shared responsibility) |
| Marketing website hosted by third party | No patient data; separate low-risk review |

_Exclusions must be justified. Auditors check this._

## 4. Interfaces and dependencies
Vendors listed in [company profile](company-profile.md). Each is assessed in `04-tprm/`.

## 5. Applicable requirements
ISO/IEC 27001:2022, UK GDPR and Data Protection Act 2018, SOC 2 customer commitments, contractual obligations to clinics, EU AI Act (for the ML feature).

## 6. Roles
| Role | Responsibility |
|---|---|
| CEO | Accountable for risk acceptance and ISMS resources |
| CTO | Owns technical controls (first line) |
| Head of Security and Compliance | Runs the ISMS, risk process, monitoring (second line) |
| DPO | Advises on UK GDPR and data protection impact assessments |
| Internal audit (outsourced) | Independent assurance (third line) |

## 7. Approval
| Version | Date | Author | Approved by |
|---|---|---|---|
| 0.1 | 17 October 2026 | Matthew Sackey | _CEO (fictional)_ |
