locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  region         = data.aws_region.current.name
  team           = "demoteam"
  environment    = "dev"
  app_name       = "demo"
  vpc_config = {
    dev = {
      "cidr"            = "192.168.0.0/20"
      "private_subnets" = ["192.168.0.0/22", "192.168.4.0/22"]
      "public_subnets"  = ["192.168.8.0/22", "192.168.12.0/22"]
    },
    test = {
      "cidr"            = "172.30.32.0/20"
      "private_subnets" = ["172.30.32.0/22", "172.30.36.0/22"]
      "public_subnets"  = ["172.30.40.0/22", "172.30.44.0/22"]
    },
    prod = {
      "cidr"            = "10.10.0.0/20"
      "private_subnets" = ["10.10.0.0/22", "10.10.4.0/22"]
      "public_subnets"  = ["10.10.8.0/22", "10.10.12.0/22"]
    },

  }
}