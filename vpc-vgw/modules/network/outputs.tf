output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_01_id" {
  description = "The ID of the public subnet 01"
  value       = aws_subnet.public_subnet_01.id
}

output "public_subnet_02_id" {
  description = "The ID of the public subnet 02"
  value       = aws_subnet.public_subnet_02.id
}

output "private_subnet_01_id" {
  description = "The ID of the private subnet 01"
  value       = aws_subnet.private_subnet_01.id
}

output "private_subnet_02_id" {
  description = "The ID of the private subnet 02"
  value       = aws_subnet.private_subnet_02.id
}
