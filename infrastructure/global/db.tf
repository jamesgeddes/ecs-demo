module "catfacts_db" {
  source = "../modules/dynamobd_table"
  aws_region = local.aws_region
  environment = local.environment
  project = local.project
  service = local.service
  table_name = local.table_name
}