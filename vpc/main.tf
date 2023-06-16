module "network" {
  source = "./modules/network"

  sysid = local.sysid
  env   = local.env

  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}
