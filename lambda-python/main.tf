module "lambda_python" {
  source = "./modules/lambda-python"

  name_prefix    = "demo"
  event_schedule = "cron(* * * * ? *)" # every min
}
