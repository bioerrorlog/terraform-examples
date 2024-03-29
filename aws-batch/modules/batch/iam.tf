data "aws_iam_policy_document" "assume_ecs_task" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "assume_batch" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "assume_events" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}


######################
# Task Execution Role
######################
resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.sysid}-${var.env}-batch-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_ecs_task.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  for_each = {
    AmazonECSTaskExecutionRolePolicy = data.aws_iam_policy.refs["AmazonECSTaskExecutionRolePolicy"],
  }

  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = each.value.arn
}


######################
# Task Role
######################
resource "aws_iam_role" "ecs_task" {
  name               = "${var.sysid}-${var.env}-batch-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_ecs_task.json
}

resource "aws_iam_role_policy_attachment" "ecs_task" {
  for_each = {
    AmazonS3ReadOnlyAccess = data.aws_iam_policy.refs["AmazonS3ReadOnlyAccess"],
  }

  role       = aws_iam_role.ecs_task.name
  policy_arn = each.value.arn
}


######################
# Batch Service Role
######################
resource "aws_iam_role" "batch_service" {
  name               = "${var.sysid}-${var.env}-batch-service-role"
  assume_role_policy = data.aws_iam_policy_document.assume_batch.json
}

resource "aws_iam_role_policy_attachment" "batch_service" {
  for_each = {
    AWSBatchServiceRole = data.aws_iam_policy.refs["AWSBatchServiceRole"],
  }

  role       = aws_iam_role.batch_service.name
  policy_arn = each.value.arn
}


######################
# Events Role
######################
resource "aws_iam_role" "trigger_batch" {
  name               = "${var.sysid}-${var.env}-trigger-batch-role"
  assume_role_policy = data.aws_iam_policy_document.assume_events.json
}

resource "aws_iam_role_policy_attachment" "trigger_batch" {
  for_each = {
    trigger_batch = aws_iam_policy.trigger_batch,
  }

  role       = aws_iam_role.trigger_batch.name
  policy_arn = each.value.arn
}

resource "aws_iam_policy" "trigger_batch" {
  name        = "${var.sysid}-${var.env}-trigger-batch"
  path        = "/"
  description = "IAM policy for trigger the AWS Batch resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "batch:SubmitJob",
        ]
        Resource = [
          "arn:aws:batch:${local.region}:${local.account_id}:job-definition/${aws_batch_job_definition.this.name}:*",
          aws_batch_job_queue.this.arn,
          "arn:aws:batch:${local.region}:${local.account_id}:job/*",
        ]
      }
    ]
  })
}
