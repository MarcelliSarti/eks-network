# module "vpc" {
#   source = "./vpc"

#   project_name = var.project_name
#   region       = var.region

#   vpc_cidr            = var.vpc_cidr
#   vpc_additional_cidrs = var.vpc_additional_cidrs

#   public_subnets   = var.public_subnets
#   private_subnets  = var.private_subnets
#   database_subnets = var.database_subnets
# }