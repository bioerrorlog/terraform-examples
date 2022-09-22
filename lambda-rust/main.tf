module "lambda_rust" {
  source = "./modules/lambda-rust"

  name_prefix     = "demo"
  lambda_schedule = "cron(* * * * ? *)" # every min
}
