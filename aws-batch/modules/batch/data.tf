data "aws_iam_policy" "refs" {
  for_each = toset([
    "AmazonECSTaskExecutionRolePolicy",
    "AmazonS3ReadOnlyAccess",
    "AWSBatchServiceRole",
  ])
  name = each.value
}
