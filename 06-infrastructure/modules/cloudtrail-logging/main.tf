terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  trail_arn = "arn:aws:cloudtrail:${var.region}:${data.aws_caller_identity.current.account_id}:trail/${var.trail_name}"
}

module "log_bucket" {
  source              = "../s3-secure"
  bucket_prefix       = "northbridge-lab-cloudtrail-"
  owner               = var.owner
  data_classification = "confidential"
  force_destroy       = true
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = module.log_bucket.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:GetBucketAcl"
        Resource  = module.log_bucket.bucket_arn
        Condition = { StringEquals = { "aws:SourceArn" = local.trail_arn } }
      },
      {
        Sid       = "AWSCloudTrailWrite"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:PutObject"
        Resource  = "${module.log_bucket.bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
            "aws:SourceArn" = local.trail_arn
          }
        }
      }
    ]
  })
}

resource "aws_cloudtrail" "this" {
  name                          = var.trail_name
  s3_bucket_name                = module.log_bucket.bucket_id
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true

  tags = {
    Project   = "northbridge-grc"
    Owner     = var.owner
    ManagedBy = "terraform"
  }

  depends_on = [aws_s3_bucket_policy.cloudtrail]
}