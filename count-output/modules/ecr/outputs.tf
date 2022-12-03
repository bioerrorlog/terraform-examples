output "aws_ecr_repository" {
  value = one(aws_ecr_repository.this[*])
  # value = try(aws_ecr_repository.this[0], {})
}
