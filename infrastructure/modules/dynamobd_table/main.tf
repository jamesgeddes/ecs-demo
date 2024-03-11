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
      Environment = var.environment
      Name        = "${local.table_full_name}-table"
      ManagedBy   = "Terraform"
    }
  }
}
