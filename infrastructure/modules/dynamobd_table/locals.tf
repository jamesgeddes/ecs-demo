locals {
    resource_prefix = lower("${var.project}-${var.environment}-${var.service}")
  table_full_name = lower("${local.resource_prefix}-${var.table_name}")
}