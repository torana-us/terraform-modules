locals {
  ipv6_only = var.cidr_block == null
  ipv6_enable = var.ipv6_cidr_block != null
}

resource "aws_subnet" "this" {
  cidr_block        = var.cidr_block
  vpc_id            = var.vpc_id
  availability_zone = var.az

  ipv6_cidr_block                                = var.ipv6_cidr_block
  ipv6_native                                    = local.ipv6_only
  enable_dns64                                   = local.ipv6_enable
  assign_ipv6_address_on_creation                = local.ipv6_enable
  enable_resource_name_dns_aaaa_record_on_launch = local.ipv6_enable

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

resource "aws_route" "gateway_ipv6" {
  count = var.gateway_route_ipv6 == null ? 0 : 1

  route_table_id              = aws_route_table.this.id
  destination_ipv6_cidr_block = var.gateway_route_ipv6.destination_cidr_block
  gateway_id                  = var.gateway_route_ipv6.gateway_id
}
