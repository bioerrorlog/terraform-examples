module "lambda_go" {
  source = "./modules/lambda-go"

  name_prefix     = "demo"
  lambda_schedule = "cron(* * * * ? *)" # every min
}
