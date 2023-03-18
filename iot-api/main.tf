module "iot_api_gateway" {
  source = "./modules/iot-api-gateway"

  name_prefix = local.name_prefix
}

module "edge" {
  source = "./modules/edge"

  name_prefix = local.name_prefix
}
