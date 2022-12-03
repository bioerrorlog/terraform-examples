module "ecr_create_example" {
  source = "./modules/ecr"

  create = true
  # create = false

  name_prefix = "create_example"
}
