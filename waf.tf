/*
module "waf" {
  source        = "git@github.com:cloudprodigy/terraform-aws-waf?ref=1.1.0"
  name          = "${var.app_name}-waf"
  alb_arn       = module.alb.alb_arn
  associate_alb = true
  scope         = "REGIONAL"

  environment        = var.environment
  tag_application    = var.tag_application
  tag_parent_project = var.tag_parent_project
  tag_cost_center    = var.tag_cost_center
  tag_key_contact    = var.tag_key_contact
}
*/