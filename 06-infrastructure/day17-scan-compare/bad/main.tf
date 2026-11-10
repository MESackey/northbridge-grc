# DELIBERATELY INSECURE. Scanner test only. Never run terraform apply here.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "patient_exports" {
  bucket = "northbridge-patient-exports-demo"
}

resource "aws_s3_bucket_public_access_block" "patient_exports" {
  bucket                  = aws_s3_bucket.patient_exports.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "admin_access" {
  name = "northbridge-admin-access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_policy" "full_access" {
  name = "northbridge-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_ebs_volume" "scheduling_data" {
  availability_zone = "eu-west-2a"
  size              = 20
  encrypted         = false
}