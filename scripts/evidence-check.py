"""Day 18: read-only evidence check for an AWS account.

Checks:
  S3-PAB   every S3 bucket has all four Public Access Block settings on
  IAM-MFA  every IAM user with a console password has an MFA device
  ROOT-MFA the root account has MFA enabled

Writes evidence/day18-evidence-report.csv, one row per resource checked.
This script only READS. It never creates, changes or deletes anything.
"""
import csv
import datetime
import os

import boto3
from botocore.exceptions import ClientError

OUTPUT = os.path.join("evidence", "day18-evidence-report.csv")

# My own mapping to ISO/IEC 27001:2022 Annex A. It is a judgement, not an official one.
CONTROL = {
    "S3-PAB": "A.8.3 Information access restriction",
    "IAM-MFA": "A.8.5 Secure authentication",
    "ROOT-MFA": "A.8.5 Secure authentication; A.8.2 Privileged access rights",
}

rows = []


def record(check, resource, passed, detail):
    rows.append({
        "checked_at_utc": datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d %H:%M:%S"),
        "check_id": check,
        "resource": resource,
        "result": "PASS" if passed else "FAIL",
        "detail": detail,
        "iso27001_2022_control": CONTROL[check],
    })


s3 = boto3.client("s3")
iam = boto3.client("iam")

# 1. S3 Public Access Block
for bucket in s3.list_buckets()["Buckets"]:
    name = bucket["Name"]
    try:
        cfg = s3.get_public_access_block(Bucket=name)["PublicAccessBlockConfiguration"]
        off = [setting for setting, value in cfg.items() if not value]
        record("S3-PAB", name, not off, "all four settings on" if not off else "off: " + ", ".join(off))
    except ClientError as err:
        if err.response["Error"]["Code"] == "NoSuchPublicAccessBlockConfiguration":
            record("S3-PAB", name, False, "no Public Access Block configured")
        else:
            record("S3-PAB", name, False, "could not check: " + err.response["Error"]["Code"])

# 2. MFA for every IAM user who can sign in to the console
for page in iam.get_paginator("list_users").paginate():
    for user in page["Users"]:
        name = user["UserName"]
        try:
            iam.get_login_profile(UserName=name)
        except ClientError as err:
            if err.response["Error"]["Code"] == "NoSuchEntity":
                continue  # no console password, so MFA at sign-in does not apply
            raise
        devices = iam.list_mfa_devices(UserName=name)["MFADevices"]
        record("IAM-MFA", name, bool(devices), "MFA device present" if devices else "console access with no MFA")

# 3. MFA on the root account
summary = iam.get_account_summary()["SummaryMap"]
record("ROOT-MFA", "root account", summary.get("AccountMFAEnabled") == 1,
       "root MFA enabled" if summary.get("AccountMFAEnabled") == 1 else "root MFA not enabled")

os.makedirs("evidence", exist_ok=True)
with open(OUTPUT, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()) if rows else ["note"])
    writer.writeheader()
    writer.writerows(rows)

passed = sum(r["result"] == "PASS" for r in rows)
print(f"{len(rows)} checks: {passed} PASS, {len(rows) - passed} FAIL. Report: {OUTPUT}")