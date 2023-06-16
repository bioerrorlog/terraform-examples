output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "The ID of the Subnet"
  value       = aws_subnet.this.id
}

output "route_table_id" {
  description = "The ID of the Route table"
  value       = aws_route_table.this.id
}

output "vgw_id" {
  description = "The ID of the Virtual Private Gateway"
  value       = aws_vpn_gateway.this.id
}
