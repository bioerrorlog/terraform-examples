resource "aws_ecr_repository" "this" {
  name  = "${var.name_prefix}_ecr"
  count = var.create ? 1 : 0
}
