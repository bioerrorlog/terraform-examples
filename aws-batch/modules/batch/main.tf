resource "aws_batch_job_definition" "this" {
  name = "${var.sysid}-${var.env}-job-definition"
  type = "container"

  platform_capabilities = [
    "FARGATE",
  ]

  container_properties = jsonencode({
    command = ["aws", "s3", "ls"]
    image   = "public.ecr.aws/amazonlinux/amazonlinux:2023"

    jobRoleArn       = aws_iam_role.ecs_task.arn
    executionRoleArn = aws_iam_role.ecs_task_execution.arn

    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }

    resourceRequirements = [
      {
        type  = "VCPU"
        value = "0.25"
      },
      {
        type  = "MEMORY"
        value = "512"
      }
    ]
  })
}
