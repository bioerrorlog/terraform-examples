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
  for_each = {
    "public_subnet_01" = aws_subnet.public_subnet_01.id
    "public_subnet_02" = aws_subnet.public_subnet_02.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_vgw" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_vpn_gateway.this.id
  }

  tags = {
    Name = "${var.sysid}-${var.env}-private-vgw-rtb"
  }
}

resource "aws_route_table_association" "private_vgw" {
  for_each = {
    "private_subnet_01" = aws_subnet.private_subnet_01.id
    "private_subnet_02" = aws_subnet.private_subnet_02.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
