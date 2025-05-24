provider "aws" {
    region = var.aws_region
}

locals {
  ec2_config = {
    aws_region = var.aws_region
    ami = var.ami
    instance_type = var.instance_type
    environment = var.environment
  }
}

module "vpc_module" {
  source = "./modules/base-infra"
}

# module "ec2_module" {
#   source = "./modules/module-ec2"
#   config = local.ec2_config
#   subnet_ids = module.vpc_module.public_subnet_ids
#   depends_on = [ module.vpc_module ]
# }