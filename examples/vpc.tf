module "vpc" {
  source          = "cloudprodigy/vpc/aws"
  version         = "2.0.3"
  name            = "${local.app_name}-${local.environment}"
  cidr            = lookup(lookup(local.vpc_config, local.environment), "cidr")
  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = lookup(lookup(local.vpc_config, local.environment), "private_subnets")
  public_subnets  = lookup(lookup(local.vpc_config, local.environment), "public_subnets")
  tag_application = local.app_name
  tag_team        = local.team
  environment     = local.environment
}