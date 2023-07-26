resource "aws_cloudwatch_event_rule" "this" {
  name        = "${var.sysid}-${var.env}-trigger-batch"
  description = "Triggers AWS Batch Job"

  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "batch_event_target" {
  rule = aws_cloudwatch_event_rule.this.name

  arn = aws_batch_job_queue.this.arn
  batch_target {
    job_name       = "ScheduledAwsS3Linting"
    job_definition = aws_batch_job_definition.this.arn
  }
}
