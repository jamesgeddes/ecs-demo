resource "aws_security_group" "web_alb_sg" {
  name        = "${local.resource_prefix}-alb-sg"
  description = "ALB security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "this" {
  name   = "${local.resource_prefix}-app-sg"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "this" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = -1
  source_security_group_id = aws_security_group.web_alb_sg.id
  security_group_id        = aws_security_group.this.id
}


resource "aws_security_group_rule" "egress_rules" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = -1
}