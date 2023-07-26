data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy" "refs" {
  for_each = toset([
    "AmazonECSTaskExecutionRolePolicy",
    "AmazonS3ReadOnlyAccess",
    "AWSBatchServiceRole",
  ])
  name = each.value
}
