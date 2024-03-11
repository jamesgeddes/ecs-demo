module "state_bucket" {
  source = "../modules/s3_bucket"
  aws_region = local.aws_region
  environment = "global"
  name = "state_bucket"
  project = "ecs-demo"
  service = "tfstate"
}

module "artefacts_bucket" {
  source = "../modules/s3_bucket"
  aws_region = local.aws_region
  environment = "global"
  name = "artefact_bucket"
  project = "ecs-demo"
  service = "artefacts"
}

module "web_container_repo" {
  source = "../modules/ecr"
  aws_region = local.aws_region
  name = "docker"
  project = local.project
  service = local.service
}