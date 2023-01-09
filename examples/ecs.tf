locals {
  # environment vars required for containers
  backend_envs = [
    { "name" : "DB_HOST", "value" : "localhost" },
    { "name" : "DB_USER", "value" : "user1" }
  ]

  # global vars for container port, cpu and mem. Individual settings can be changed below
  container_port = 3000
  cpu            = 512
  memory         = 1024
}
module "ecs" {
  source = "../"

  app_name         = local.app_name
  ecs_cluster_name = local.app_name
  subnets          = module.vpc.private_subnets

  enable_service_discovery = "yes"

  create_alb             = true
  lb_subnets             = module.vpc.public_subnets
  logging_lb_bucket_name = "" #logging bucket ARN to store ALB logs
  http_redirect          = "yes"
  certificate_arn        = "" # ACM Cert ARN
  lb_name                = local.app_name
  is_internal            = "no"

  account_id     = local.aws_account_id
  ecr_account_id = "0123456" #Account id where ECR repos are created, usually the dev environment
  region         = local.region
  environment    = local.environment
  vpc_id         = element(module.vpc.*.vpc_id, count.index)

  ecs_applications = {
    app1 = {
      name           = "app1" #container name
      env_vars       = local.backend_envs
      attach_alb     = "no" # don't attach the service to ALB if the svc is private
      enable_service = "yes"
      container_port = local.container_port # using global vars for container port, cpu and mem
      cpu            = local.cpu
      memory         = local.memory
    },
    app2 = {
      name           = "app2"
      env_vars       = local.backend_envs
      attach_alb     = "yes" # attach the svc to ALB if it's a public svc
      enable_service = "yes"
      container_port = 3001 # using individual settings for container port, cpu and mem
      cpu            = 256
      memory         = 512
      #NOTE: cpu and mem for a container should not exceed the values defined in the Task Definition
    }
  }

  # ALB Target Groups & Listener Rules for public apps
  alb_target_groups = {
    "app2" = {
      name              = "app2-tg"
      path_patterns     = ["/*"]
      target_group_port = 3000
      priority          = 1
    }
  }

  enable_cicd = "no" # Disable or Enable CodePipeline setup for above apps
}