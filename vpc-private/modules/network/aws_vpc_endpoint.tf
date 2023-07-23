resource "aws_vpc_endpoint" "interface" {
  for_each = {
    ec2messages = "com.amazonaws.${local.region}.ec2messages",
    ssm         = "com.amazonaws.${local.region}.ssm",
    ssmmessages = "com.amazonaws.${local.region}.ssmmessages",
  }

  vpc_endpoint_type = "Interface"
  service_name      = each.value
  vpc_id            = aws_vpc.this.id

  security_group_ids = [aws_security_group.interface_vpc_endpoint.id]
  subnet_ids         = values(local.private_subnet_ids)

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
