resource "aws_ecs_task_definition" "web_service" {
  family                   = local.family_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = module.ecs.task_exec_iam_role_arn
  container_definitions = jsonencode([
    {
      name      = local.container_name
      image     = data.aws_ecr_image.web_container.image_uri,
      essential = true
      environment = [
        # Place your environment variables here, e.g pass DB endpoint
        # "name": "MYSQL_DATABASE", "value": "Your-Database-Endpoint"
        ]
      secrets = [
                {
                    "name": "AWS_ACCESS_KEY_ID",
                    "valueFrom": "${data.aws_ssm_parameter.access_key.arn}"
                },
                {
                    "name": "AWS_SECRET_ACCESS_KEY",
                    "valueFrom": "${data.aws_ssm_parameter.secret_key.arn}"
                }
            ]              
      portMappings = [
        {
          containerPort = local.container_port
        }
      ]
      ###########################################################################
      # Un-Comment If you Want to Enable CloudWatch Logging -> Additional Charges
      ###########################################################################
      # logConfiguration: {
      #     logDriver = "awslogs",
      #     options = {
      #         "awslogs-create-group": "true",
      #         "awslogs-group": "/ecs/ecs-aws-otel-sidecar-collector",
      #         "awslogs-region": "${var.aws_region}",
      #         "awslogs-stream-prefix": "ecs"
      #   }
      # }      
    }
  ])

}
