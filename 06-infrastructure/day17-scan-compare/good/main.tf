# Remediated version of ../bad. Scanner test only. Never run terraform apply here.

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
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "patient_exports" {
  bucket = aws_s3_bucket.patient_exports.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "patient_exports" {
  bucket = aws_s3_bucket.patient_exports.id

  versioning_configuration {
    status = "Enabled"
  }
}

# The 90 days below is an example value, not a retention policy.
# The real period is a business decision (UK GDPR storage limitation, ISO 27001 A.8.10).
resource "aws_s3_bucket_lifecycle_configuration" "patient_exports" {
  bucket = aws_s3_bucket.patient_exports.id

  rule {
    id     = "tidy-up"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

resource "aws_security_group" "admin_access" {
  name        = "northbridge-admin-access"
  description = "SSH from the internal admin network only"

  ingress {
    description = "SSH from internal admin network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    description = "HTTPS to internal network"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_iam_policy" "read_exports" {
  name = "northbridge-read-exports"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.patient_exports.arn}/*"
      }
    ]
  })
}

resource "aws_ebs_volume" "scheduling_data" {
  availability_zone = "eu-west-2a"
  size              = 20
  encrypted         = true
}