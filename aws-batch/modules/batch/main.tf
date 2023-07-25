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

resource "aws_batch_compute_environment" "this" {
  compute_environment_name = "${var.sysid}-${var.env}-compute-environment"

  compute_resources {
    max_vcpus = 16

    security_group_ids = [
      aws_security_group.batch_compute.id,
    ]

    subnets = var.subnet_ids

    type = "FARGATE"
  }

  service_role = aws_iam_role.batch_service.arn
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.batch_service]
}

resource "aws_security_group" "batch_compute" {
  name = "${var.sysid}-${var.env}-batch-compute-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
