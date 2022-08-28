####################################################
# Lambda Function
####################################################

resource "aws_lambda_function" "this" {
  function_name = "hello_lambda"

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  role    = aws_iam_role.iam_for_lambda.arn
  handler = "hello_lambda.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      greeting = "Hello"
    }
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/hello_lambda.py"
  output_path = "${path.module}/hello_lambda.zip"
}


####################################################
# IAM
####################################################

resource "aws_iam_role" "this" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

data "aws_iam_policy_document" "assume_lambda" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}
