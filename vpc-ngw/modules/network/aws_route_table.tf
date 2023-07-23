resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.sysid}-${var.env}-public-rtb"
  }
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.sysid}-${var.env}-private-rtb"
  }
}

resource "aws_route_table_association" "private" {
  for_each = local.private_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
