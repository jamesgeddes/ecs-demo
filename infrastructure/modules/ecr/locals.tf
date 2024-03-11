locals {
  resource_prefix = lower("${var.project}-global-${var.service}")
  repo_full_name = lower("${local.resource_prefix}-${var.name}")

}