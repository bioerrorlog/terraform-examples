####################################################
# EventBridge
####################################################

resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.name_prefix}_trigger_lambda"
  description         = "trigger lambda function"
  schedule_expression = var.event_schedule
}

resource "aws_cloudwatch_event_target" "this" {
  arn  = aws_lambda_function.this.arn
  rule = aws_cloudwatch_event_rule.this.id
}


####################################################
# IAM
####################################################

resource "aws_iam_role" "events" {
  name               = "${var.name_prefix}_events_trigger_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_events.json
}

data "aws_iam_policy_document" "assume_events" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "events" {
  for_each = {
    for i in [
      aws_iam_policy.trigger_lambda,
    ] : i.name => i.arn
  }

  role       = aws_iam_role.events.name
  policy_arn = each.value
}
