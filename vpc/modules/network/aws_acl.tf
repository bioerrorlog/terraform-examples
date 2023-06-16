resource "aws_network_acl" "this" {
  vpc_id = aws_vpc.this.id

  egress {
    protocol   = "-1" # all
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1" # all
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.sysid}-${var.env}-acl"
  }
}

resource "aws_network_acl_association" "this" {
  for_each = toset([
    aws_subnet.public_subnet_01.id,
    aws_subnet.public_subnet_02.id,
    aws_subnet.private_subnet_01.id,
    aws_subnet.private_subnet_02.id,
  ])

  subnet_id      = each.value
  network_acl_id = aws_network_acl.this.id
}
