terraform {
  backend "s3" {
    bucket = "ecs-demo-global-tfstate-bucket"
    key    = "web/terraform.tfstate"
    encrypt = true
    region = "eu-west-2"
  }
}
