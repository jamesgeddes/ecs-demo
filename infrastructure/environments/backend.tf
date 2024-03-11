terraform {
  backend "s3" {
    bucket  = "ecs-demo-global-tfstate-bucket"
    key     = "prod/terraform.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}


