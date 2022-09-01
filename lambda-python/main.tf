module "lambda_python" {
  source = "./modules/lambda-python"

  name_prefix    = "demo"
  lambda_schedule = "cron(* * * * ? *)" # every min
}
