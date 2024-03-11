locals {
  resource_prefix = lower("${var.project}-${var.environment}-${var.service}")
  bucket_full_name = lower("${local.resource_prefix}-${var.name}")

}