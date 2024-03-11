data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ecr_image" "web_container" {
  repository_name = "ecsdemo-global-web-docker"
  most_recent     = true
}

data "aws_ssm_parameter" "access_key" {
  name = "ACCESS_KEY_ID"
}

data "aws_ssm_parameter" "secret_key" {
  name = "SECRET_ACCESS_KEY"
}