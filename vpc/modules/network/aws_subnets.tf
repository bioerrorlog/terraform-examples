resource "aws_subnet" "public_subnet_01" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_01.cidr
  availability_zone = var.public_subnet_01.az

  tags = {
    Name = "${var.sysid}-${var.env}-public-subnet01"
  }
}

resource "aws_subnet" "public_subnet_02" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_02.cidr
  availability_zone = var.public_subnet_02.az

  tags = {
    Name = "${var.sysid}-${var.env}-public-subnet02"
  }
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_01.cidr
  availability_zone = var.private_subnet_01.az

  tags = {
    Name = "${var.sysid}-${var.env}-private-subnet01"
  }
}

resource "aws_subnet" "private_subnet_02" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_02.cidr
  availability_zone = var.private_subnet_02.az

  tags = {
    Name = "${var.sysid}-${var.env}-private-subnet02"
  }
}
