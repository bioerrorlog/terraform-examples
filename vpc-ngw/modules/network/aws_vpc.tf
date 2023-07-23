resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.sysid}-${var.env}-vpc"
  }
}


####################
# Gateways
####################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.sysid}-${var.env}-igw"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet_01.id

  tags = {
    Name = "${var.sysid}-${var.env}-ngw"
  }
}

resource "aws_eip" "nat_gateway" {
  domain = "vpc"

  tags = {
    Name = "${var.sysid}-${var.env}-ngw-eip"
  }
}
