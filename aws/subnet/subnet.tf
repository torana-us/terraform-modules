resource "aws_subnet" "this" {
  cidr_block        = var.cidr_block
  vpc_id            = var.vpc_id
  availability_zone = var.az

  ipv6_cidr_block                 = var.ipv6_cidr_block
  assign_ipv6_address_on_creation = var.ipv6_cidr_block != null

  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.this.id
}

resource "aws_route" "gateway" {
  count = var.gateway_route == null ? 0 : 1

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = var.gateway_route.destination_cidr_block
  gateway_id             = var.gateway_route.gateway_id
}
