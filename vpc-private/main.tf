module "network" {
  source = "./modules/network"

  sysid = local.sysid
  env   = local.env

  vpc_cidr          = "10.0.0.0/16"
  private_subnet_01 = { cidr = "10.0.3.0/24", az = "ap-northeast-1a" }
  private_subnet_02 = { cidr = "10.0.4.0/24", az = "ap-northeast-1c" }
}
