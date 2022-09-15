####################################################
# Lambda Function
####################################################

resource "aws_lambda_function" "this" {
  function_name = "${var.name_prefix}_go_lambda_sample"
  description   = "Go lambda sample."

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  role    = aws_iam_role.this.arn
  handler = local.lambda_bin_name
  runtime = "go1.x"
}

resource "null_resource" "go_build" {
  triggers = {
    code_diff = join("", [
      for file in fileset(local.lambda_local_path, "**.go")
      : filebase64("${local.lambda_local_path}/${file}")
    ])
  }

  provisioner "local-exec" {
    command = "GOOS=linux GOARCH=amd64 go build -o ${local.lambda_bin_local_path} ${local.lambda_local_path}"
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = local.lambda_bin_local_path
  output_path = local.lambda_zip_local_path

  depends_on = [
    null_resource.go_build
  ]
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  count = var.lambda_schedule == null ? 0 : 1

  statement_id  = "${var.name_prefix}AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[0].arn
}


####################################################
# CloudWatch Logs
####################################################

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${aws_lambda_function.this.function_name}"

  retention_in_days = var.log_retention_in_days
}


####################################################
# EventBridge
####################################################

resource "aws_cloudwatch_event_rule" "this" {
  count = var.lambda_schedule == null ? 0 : 1

  name                = "${var.name_prefix}_trigger_lambda"
  description         = "trigger lambda function"
  schedule_expression = var.lambda_schedule
}

resource "aws_cloudwatch_event_target" "this" {
  count = var.lambda_schedule == null ? 0 : 1

  arn  = aws_lambda_function.this.arn
  rule = aws_cloudwatch_event_rule.this[0].id
}


####################################################
# IAM
####################################################

resource "aws_iam_role" "this" {
  name               = "${var.name_prefix}_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

data "aws_iam_policy_document" "assume_lambda" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for i in [
      aws_iam_policy.lambda_logging,
    ] : i.name => i.arn
  }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.name_prefix}_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from lambda"

  policy = templatefile(
    "${path.module}/templates/lambda_logging.json",
    {
      log_group_arn = aws_cloudwatch_log_group.this.arn
    }
  )
}

resource "aws_iam_policy" "trigger_lambda" {
  name        = "${var.name_prefix}_trigger_lambda"
  path        = "/"
  description = "IAM policy for invoking this lambda"

  policy = templatefile(
    "${path.module}/templates/trigger_lambda.json",
    {
      lambda_function_arn = aws_lambda_function.this.arn
    }
  )
}
