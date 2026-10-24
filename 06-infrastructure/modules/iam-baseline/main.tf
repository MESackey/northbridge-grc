terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 5
}

resource "aws_iam_group" "auditors" {
  name = "northbridge-auditors"
}

resource "aws_iam_group_policy_attachment" "auditors_security_audit" {
  group      = aws_iam_group.auditors.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}