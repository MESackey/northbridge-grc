# DevSecOps glossary (my own words)

## SAST (static application security testing)
- What it finds: Reads your source code without running it and spots risky coding patterns (e.g., insecure inputs, hardcoded paths).
- Who fixes it: Software engineers / Developers (first line).
- Which Northbridge risk or control it supports: Supports ISO A.8.28 (Secure coding) and NIST PR.PS.

## SCA (software composition analysis)
- What it finds: Checks the third-party open-source libraries and dependencies you use against databases of known security flaws (CVEs).
- Who fixes it: Software engineers / DevOps team (by updating or patching libraries).
- Which Northbridge risk or control it supports: Directly supports R-008 (Known flaw in a software library is exploited) and ISO A.8.8.

## IaC scanning (infrastructure as code)
- What it finds: Reads Terraform or CloudFormation scripts to spot insecure infrastructure settings (e.g., publicly exposed storage buckets or unencrypted databases) before deployment.
- Who fixes it: DevOps / Cloud Platform Engineers.
- Which Northbridge risk or control it supports: Directly supports R-001 (Patient export stored in a publicly reachable cloud storage bucket) and ISO A.8.9 / NIST PR.PS.

## Secrets scanning
- What it finds: Scans code repositories to find passwords, API tokens, and private keys accidentally committed to git.
- Who fixes it: The developer who committed the secret (by revoking and rotating the credential immediately).
- Which Northbridge risk or control it supports: The current Northbridge risk register has no dedicated risk for exposed credentials in code—a critical gap to address (supports ISO A.5.17).

## OWASP Top 10
- What it is: A regularly updated community consensus list highlighting the ten most critical security risks facing web applications today.
- Pick three items and match each to one of your risks: 

A01:2021-Broken Access Control $\rightarrow$ Maps directly to R-004 (Employee views patient records without a business need).

A05:2021 – Security Misconfiguration $\rightarrow$ Maps directly to R-001 (Publicly reachable S3 bucket).

A06:2021 – Vulnerable and Outdated Components $\rightarrow$ Maps directly to R-008 (Known flaw in a software library is exploited).

## One honest line
- What scanners cannot do, and who decides what to do with a finding: Scanners cannot understand business context or tell if a flaw is actually reachable in practice—the engineer and asset owner decide whether to fix, suppress, or accept the finding.