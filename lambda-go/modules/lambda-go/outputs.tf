output "lambda" {
  value = aws_lambda_function.this
}

output "trigger_lambda_policy" {
  value       = aws_iam_policy.trigger_lambda
  description = "IAM policy for invoking the lambda"
}
