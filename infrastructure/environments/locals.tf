locals {
  resource_prefix                = lower("${var.project}-${var.environment}")
  cluster_full_name              = lower("${local.resource_prefix}-cluster")
  aws_region                     = "eu-west-2"
  environment                    = "prod"
  project                        = "ecsdemo"
  service                        = "web"
  table_name                     = "catfacts"
  container_port                 = 5000
  container_name                 = "${local.resource_prefix}-web-service"
  alb_name                       = "${local.resource_prefix}-alb"
  family_name                    = "${local.resource_prefix}-family"
    services = {
    blue = {
      path = "/"
      port = 80
    }
    green = {
      path = "/"
      port = 80
    }
  }


}
