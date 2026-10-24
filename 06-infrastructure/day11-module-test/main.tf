terraform {
  required_version = ">= 1.9"
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

module "patient_exports" {
  source              = "../modules/s3-secure"
  bucket_prefix       = "northbridge-lab-exports-"
  owner               = "CTO"
  data_classification = "patient-data"
}

output "bucket" {
  value = module.patient_exports.bucket_id
}