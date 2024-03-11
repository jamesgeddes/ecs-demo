variable "aws_region" {
  description = "The name of the AWS region that we are working in"
  type        = string
}

variable "environment" {
  description = "The name of the environment that we are deploying to."
  type        = string
}

variable "project" {
  description = "The name of the project that we are working on."
  type        = string
}
