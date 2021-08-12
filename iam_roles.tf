resource "aws_iam_role" "ecs_node_role" {
  name               = "${var.app_name}_ecs_node_role"
  tags               = local.common_tags
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy_document.json
}
resource "aws_iam_instance_profile" "ecs" {
  name = "${var.app_name}_instance_profile"
  path = "/"
  role = aws_iam_role.ecs_node_role.name
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "${var.app_name}_ecs_service_role"
  tags               = local.common_tags
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy_document.json
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs_elb_access_policy"
  policy = data.aws_iam_policy_document.ecs_service_role_policy_document.json
  role   = aws_iam_role.ecs_service_role.id
}

resource "aws_iam_role_policy" "ecs_node_role_policy" {
  name   = "sqs_secretsmanager_access_policy"
  policy = data.aws_iam_policy_document.ecs_node_role_policy.json
  role   = aws_iam_role.ecs_node_role.id
}

#Fargate
resource "aws_iam_role" "task_execution" {
  name                = "${var.app_name}_task_execution_role"
  tags                = local.common_tags
  assume_role_policy  = data.aws_iam_policy_document.task.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

data "aws_iam_policy_document" "task" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks-amazonaws.com"]
    }
  }
}