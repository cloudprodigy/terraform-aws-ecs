# ECS Security group (traffic ALB -> ECS)
resource "aws_security_group" "ecs" {
  name        = "${var.app_name}_ecs_security_group"
  description = "Allows inbound access from the ALB only"
  tags        = local.common_tags
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }
}

resource "aws_security_group" "efs" {
  name        = "${var.app_name}_efs_sg"
  description = "Allows inbound access from the ECS only"
  vpc_id      = var.vpc_id
  tags        = local.common_tags

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }
}