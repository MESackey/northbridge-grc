# CMDB relationships: Northbridge Health Ltd

How the main assets connect (service, application, data, supplier).

```mermaid
flowchart LR
  Clinics["Clinics (customers)"] -->|use| SVC["AS-001 Scheduling platform"]
  SVC -->|runs as| APP["AS-003 Web application"]
  SVC -->|calls| ML["AS-002 ML triage feature"]
  APP -->|hosted on| AWS["AS-008 AWS production account"]
  ML -->|hosted on| AWS
  APP -->|reads and writes| DB["AS-005 Patient database"]
  DB -->|holds| DATA["AS-004 Patient appointment data"]
  APP -->|sends contact details to| SMS["AS-016 SMS provider"]
  SMS -->|holds| SMSDATA["AS-006 Patient contact details"]
  STAFF["AS-010 Corporate laptops"] -->|access| GH["AS-014 GitHub organisation"]
  STAFF -->|access| GW["AS-012 Google Workspace"]
  GH -->|deploys to| AWS
```

## Reading it
- If AWS production goes down, the scheduling platform, web app and ML feature all go down (R-003).
- If the SMS provider is breached, patient contact details are exposed (R-006).
- If a laptop is lost, the paths to GitHub and Google Workspace are exposed (R-009, R-002).

## Honest limits
- No active backup or failover plan