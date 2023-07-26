module "batch" {
  source = "./modules/batch"

  sysid = local.sysid
  env   = local.env

  vpc_id = module.network.vpc_id
  subnet_ids = [
    module.network.private_subnet_01_id,
    module.network.private_subnet_02_id,
  ]

  schedule_expression = "rate(5 minutes)"
}

module "network" {
  source = "./modules/network"

  sysid = local.sysid
  env   = local.env

  vpc_cidr          = "10.0.0.0/16"
  public_subnet_01  = { cidr = "10.0.1.0/24", az = "ap-northeast-1a" }
  public_subnet_02  = { cidr = "10.0.2.0/24", az = "ap-northeast-1c" }
  private_subnet_01 = { cidr = "10.0.3.0/24", az = "ap-northeast-1a" }
  private_subnet_02 = { cidr = "10.0.4.0/24", az = "ap-northeast-1c" }
}
