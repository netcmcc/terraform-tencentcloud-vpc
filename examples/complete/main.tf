provider "tencentcloud" {
  region = var.region
}

module "vpc" {
  source = "../../"

  enabled  = true
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones
  subnet_cidrs       = var.subnet_cidrs
  eni_subnet_cidrs   = var.eni_subnet_cidrs
  enable_nat_gateway = var.enable_nat_gateway

  tags = {
    "onwer" = "chenming"
  }
}
