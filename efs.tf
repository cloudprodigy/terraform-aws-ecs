resource "aws_efs_file_system" "efs" {
  creation_token = "${var.app_name}_efs_fs"
  encrypted      = true
  tags           = local.common_tags
}

resource "aws_efs_access_point" "this" {
  file_system_id = aws_efs_file_system.efs.id
  root_directory {
    path = "/"
  }
  tags = local.common_tags
}

resource "aws_efs_mount_target" "efs_tgt" {
  count           = length(var.private_subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = element(var.private_subnets, count.index)
  security_groups = [aws_security_group.efs.id]
}