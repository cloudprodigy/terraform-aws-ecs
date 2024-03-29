resource "aws_security_group" "ecs" {
  name        = "${var.app_name}_ecs_security_group"
  description = "Allows egress access only"

  vpc_id = var.vpc_id

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
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }
}

resource "aws_security_group" "efs" {
  count       = var.enable_efs == "yes" ? 1 : 0
  name        = "${var.app_name}_efs_sg"
  description = "Allows inbound access from the ECS only"
  vpc_id      = var.vpc_id

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

resource "aws_security_group" "load_balancer" {
  count       = var.create_alb ? 1 : 0
  name        = "${var.lb_name}_sg"
  description = "Controls access to the ALB"
  tags        = local.common_tags
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  # condition for BG deployments
  dynamic "ingress" {
    for_each = var.enable_bluegreen_deployments == "yes" ? [1] : []
    content {
      from_port   = 9443
      to_port     = 9443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }
}
