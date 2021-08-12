data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
  tags = local.common_tags

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_launch_configuration" "ecs" {
  count                       = var.launch_type == "EC2" ? 1 : 0
  name_prefix                 = "${var.ecs_cluster_name}-lc"
  image_id                    = data.aws_ami.amazon_linux_ecs.id
  instance_type               = var.ec2_instance_type
  security_groups             = [aws_security_group.ecs.id]
  iam_instance_profile        = aws_iam_instance_profile.ecs.name
  associate_public_ip_address = false
  user_data                   = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    encrypted   = true
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")
  vars = {
    cluster_name = var.ecs_cluster_name
  }
}

data "template_file" "app" {
  template = file("${path.module}/templates/container_def.json.tpl")

  vars = {
    docker_image_url = var.ecr_url
    region           = var.region
    app_name         = var.app_name
    container_path   = var.container_shared_dir_path
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.app_name
  container_definitions    = data.template_file.app.rendered
  depends_on               = [aws_efs_file_system.efs]
  cpu                      = var.launch_type == "FARGATE" ? 256 : null
  memory                   = var.launch_type == "FARGATE" ? 512 : null
  requires_compatibilities = ["EC2", "FARGATE"]
  network_mode             = var.launch_type == "FARGATE" ? "awsvpc" : "bridge"
  #task_role_arn            = var.launch_type == "FARGATE" ? aws_iam_role.task_execution.arn : null
  execution_role_arn = var.launch_type == "FARGATE" ? aws_iam_role.task_execution.arn : null
  #tfsec:ignore:AWS096

  volume {
    name = "shared"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs.id
      root_directory = "/"
    }
  }
  tags = local.common_tags
}

resource "aws_ecs_service" "this" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.this.arn
  iam_role        = var.launch_type == "FARGATE" ? null : aws_iam_role.ecs_service_role.arn
  desired_count   = var.app_count
  depends_on      = [aws_iam_role_policy.ecs_service_role_policy]
  launch_type     = var.launch_type

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.app_name
    container_port   = var.container_port
  }
  tags = local.common_tags
}
