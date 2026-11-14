# Day 20 demo: proves the pipeline blocks insecure Terraform. Never run terraform apply here.
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

resource "aws_security_group" "demo" {
  name        = "day20-demo"
  description = "Day 20 demo security group"

  ingress {
    description = "SSH from the internal admin range"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }
}

resource "aws_ebs_volume" "demo" {
  availability_zone = "eu-west-2a"
  size              = 10
  encrypted         = true
}