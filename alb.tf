/*
module "alb" {
  source = "git@github.com:cloudprodigy/terraform-aws-load-balancer?ref=v1.1.0"

  create_alb = true
  lb_name    = "${var.app_name}-lb"

  target_group_name = "${var.app_name}-tg"
  health_check_path = var.health_check_path #default is /
  lb_subnets        = var.private_subnets

  vpc_id          = var.vpc_id
  certificate_arn = var.certificate_arn

  environment        = var.environment
  tag_application    = var.tag_application
  tag_parent_project = var.tag_parent_project
  tag_cost_center    = var.tag_cost_center
  tag_key_contact    = var.tag_key_contact

}
*/