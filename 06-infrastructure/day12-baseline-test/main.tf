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

module "iam_baseline" {
  source = "../modules/iam-baseline"
}

module "logging" {
  source = "../modules/cloudtrail-logging"
  owner  = "Head of Security and Compliance"
}

output "trail" {
  value = module.logging.trail_name
}