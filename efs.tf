resource "aws_efs_file_system" "efs" {
  count          = var.enable_efs == "yes" ? 1 : 0
  creation_token = "${var.app_name}_efs_fs"
  encrypted      = true

}

resource "aws_efs_access_point" "this" {
  count          = var.enable_efs == "yes" ? 1 : 0
  file_system_id = aws_efs_file_system.efs[count.index].id
  root_directory {
    path = "/"
  }

}

resource "aws_efs_mount_target" "efs_tgt" {
  count           = var.enable_efs == "yes" ? length(var.subnets) : 0
  file_system_id  = one(aws_efs_file_system.efs.*.id)
  subnet_id       = element(var.subnets, count.index)
  security_groups = [one(aws_security_group.efs.*.id)]
}