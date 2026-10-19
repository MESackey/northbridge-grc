# AI Tools policy: Northbridge Health Ltd

| Field | Value |
|---|---|
| Version | 0.1 (draft) |
| Policy owner | Head of Security and Compliance |
| Approved by | CEO (fictional) |
| Effective date | 18 October 2026 |
| Next review | 18 October 2027 |

## 1. Purpose
Establish mandatory controls for adopting and using Artificial Intelligence (AI) tools, Machine Learning (ML) models, and Large Language Models (LLMs) safely and ethically across Northbridge operations.

## 2. Scope
All employees, contractors, and development teams utilising consumer or enterprise AI tools, embedded AI features, or developing custom ML algorithms for Northbridge.

## 3. Policy statements
1. **Approved tools register.** Only AI tools explicitly reviewed by Security and listed on the Approved AI Tools Register may be used for company business.
2. **Data input restrictions.** Patient data, system credentials, corporate intellectual property, and proprietary source code must never be entered into unapproved or public consumer AI tools.
3. **Mandatory human oversight.** AI-generated content, technical documentation, clinical summaries, or code must be reviewed and verified by a qualified staff member before operational use. The reviewer retains full accountability.
4. **Code pipeline integration.** All code produced or assisted by AI tools must pass through standard CI/CD security controls, including static analysis, automated dependency scanning, and peer code review.
5. **Vendor security pre-assessment.** New third-party AI platforms must undergo third-party risk management (TPRM) assessment before procurement to verify model training data privacy and data retention policies.
6. **Clinical triage and safety guardrails.** AI and ML outputs must never make autonomous patient triage or care decisions. All clinical outputs require mandatory sign-off by a licensed clinician.
7. **Prohibition of model training on company data.** Enterprise agreements for AI tools must explicitly opt out of using Northbridge data or prompts to train public or foundational models.
8. **AI incident reporting.** Any algorithm bias, hallucination leading to operational error, or unexpected data leakage involving AI tools must be reported immediately to Security and Compliance.
9. **Bi-annual policy review.** Due to rapid technological advances and evolving AI regulations, this policy must be reviewed and updated every 6 months.

## 4. Roles
| Role | Responsibility |
|---|---|
| CEO | Approves overall AI risk tolerance and high-impact clinical AI deployments |
| CTO | Ensures AI-generated code passes CI/CD scans and manages clinical ML model deployment (first line) |
| Head of Security and Compliance | Conduct TPRM assessment on AI vendors, maintains the AI Tools Register, and updates policy bi-annually (second line) |
| Data Protection Officer (DPO) | Audits AI systems for data protection compliance and automated decision-making impact (UK GDPR) |

## 5. Enforcement
Unauthorised input of patient data or proprietary code into unclassified AI tools constitutes a severe security breach and may lead to immediate suspension and disciplinary proceedings.

## 6. Mapping and related risks
- ISO/IEC 27001:2022: A.5.10, A.5.19, A.5.20, A.5.21, A.5.22, A.5.23, A.8.12, A.8.28
- NIST AI RMF 1.0: GOVERN 1.1, GOVERN 1.2, MAP 1.1, MEASURE 2.1
- ISO/IEC 42001:2023: (Reference framework for AI Management Systems)
- Related risks: R-007, R-008, R-011