module "subnet" {
  source = "../../"

  for_each = local.subnets

  vpc_id          = aws_vpc.vpc.id
  az              = each.value.az
  ipv6_cidr_block = each.value.ipv6_cidr_block
  gateway_route_ipv6 = {
    destination_cidr_block = "::/0"
    gateway_id             = aws_internet_gateway.gateway.id
  }
  name = each.key
}

locals {
  cidr_block = "192.168.0.0/16"
  subnets = {
    subnet-1a_1 = {
      az              = "ap-northeast-1a"
      ipv6_cidr_block = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 1)
    }
    subnet-1c_1 = {
      az              = "ap-northeast-1c"
      ipv6_cidr_block = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 2)
    }
    subnet-1d_1 = {
      az              = "ap-northeast-1d"
      ipv6_cidr_block = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 3)
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block                       = local.cidr_block
  assign_generated_ipv6_cidr_block = true
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
}
