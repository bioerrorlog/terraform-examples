###################
# Interface type
###################
resource "aws_vpc_endpoint" "interface" {
  for_each = {
    ec2 = "com.amazonaws.${local.region}.ec2"
  }

  vpc_endpoint_type = "Interface"
  service_name      = each.value
  vpc_id            = aws_vpc.this.id

  security_group_ids = [aws_security_group.interface_vpc_endpoint.id]
  subnet_ids         = values(local.private_subnet_ids) # Restriction: max 1 endpoint per AZ

  private_dns_enabled = true

  tags = {
    Name = "${var.sysid}-${var.env}-${each.key}-interface"
  }
}

resource "aws_security_group" "interface_vpc_endpoint" {
  name   = "${var.sysid}-${var.env}-interface-vpc-endpoint"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  tags = {
    Name = "${var.sysid}-${var.env}-interface-vpc-endpoint"
  }
}

###################
# Gateway type
###################
resource "aws_vpc_endpoint" "gateway" {
  for_each = {
    s3 = "com.amazonaws.${local.region}.s3"
  }

  vpc_endpoint_type = "Gateway"
  service_name      = each.value
  vpc_id            = aws_vpc.this.id

  tags = {
    Name = "${var.sysid}-${var.env}-${each.key}-gateway"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_vgw" {
  vpc_endpoint_id = aws_vpc_endpoint.gateway["s3"].id
  route_table_id  = aws_route_table.private_vgw.id
}
