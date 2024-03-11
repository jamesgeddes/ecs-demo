terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }

}
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Name        = "${local.repo_full_name}-repo"
      ManagedBy   = "Terraform"
    }
  }
}
