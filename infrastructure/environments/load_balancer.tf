resource "aws_lb" "web_alb" {
  name                       = "${local.resource_prefix}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.web_alb_sg.id]
  subnets                    = [
    module.vpc.public_subnets[0],  # Subnet in AZ 1
    module.vpc.public_subnets[1],  # Subnet in AZ 2
    module.vpc.public_subnets[2],  # Subnet in AZ 3
  ]
  enable_deletion_protection = false

}


resource "aws_lb_listener" "web_alb_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }
}

resource "aws_lb_target_group" "web_alb_tg" {
  name     = "${local.resource_prefix}-alb-tg"
  port     = local.container_port # Replace with your container's port
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    enabled  = true
    path     = "/" # Adjust based on your application's health check endpoint
    protocol = "HTTP"
    matcher  = "200"
  }
}