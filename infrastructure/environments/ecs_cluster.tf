module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.9.0"

  create_task_exec_iam_role = true
  task_exec_iam_role_name   = "${local.resource_prefix}-task-exec-role"

  cluster_name = "${local.resource_prefix}-ecs"
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        base   = 20
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }
}





