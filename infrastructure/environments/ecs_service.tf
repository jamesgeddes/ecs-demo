resource "aws_ecs_service" "this" {
  cluster         = module.ecs.cluster_id
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "${local.resource_prefix}-service"
  task_definition = aws_ecs_task_definition.web_service.arn

  lifecycle {
    ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly around auto-scaling.
  }

  load_balancer {
    container_name   = "${local.resource_prefix}-web-service"
    container_port   = local.container_port
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }

  network_configuration {
    security_groups  = [aws_security_group.this.id]
    subnets          = module.vpc.private_subnets
    assign_public_ip = true
  }

}