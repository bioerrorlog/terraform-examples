data "aws_iam_policy_document" "assume_ecs_task" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
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
  for_each = toset([
    data.aws_iam_policy.refs["AmazonECSTaskExecutionRolePolicy"],
  ])

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
  for_each = toset([
    data.aws_iam_policy.refs["AmazonS3ReadOnlyAccess"],
  ])

  role       = aws_iam_role.ecs_task.name
  policy_arn = each.value.arn
}
