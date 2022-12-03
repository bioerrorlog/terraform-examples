output "aws_ecr_repository" {
  value = one(aws_ecr_repository.this[*])
}
