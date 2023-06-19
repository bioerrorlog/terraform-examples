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
  for_each = local.all_subnet_ids

  subnet_id      = each.value
  network_acl_id = aws_network_acl.this.id
}
