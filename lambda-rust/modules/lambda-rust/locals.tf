locals {
  lambda_local_path     = "${path.module}/lambda"
  lambda_bin_name = "bootstrap"
  lambda_bin_local_path = "${local.lambda_local_path}/target/lambda/lambda/${local.lambda_bin_name}"
  lambda_zip_local_path = "${local.lambda_bin_local_path}.zip"
}
