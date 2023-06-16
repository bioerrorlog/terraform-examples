resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.sysid}-${var.env}-vpc"
  }
}

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
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.sysid}-${var.env}-acl"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.sysid}-${var.env}-igw"
  }
}

resource "aws_vpn_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.sysid}-${var.env}-vgw"
  }
}
