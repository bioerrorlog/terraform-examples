resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.sysid}-${var.env}-private-rtb"
  }
}

resource "aws_route_table_association" "private" {
  for_each = local.private_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
