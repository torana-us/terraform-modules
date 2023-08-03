variable "cidr_block" {
  type    = string
  default = null
}

variable "vpc_id" {
  type = string
}

variable "az" {
  type = string
}

variable "gateway_route" {
  type = object({
    destination_cidr_block = string
    gateway_id             = string
  })
  description = "specify igw or vpg"
  default     = null
}

variable "gateway_route_ipv6" {
  type = object({
    destination_cidr_block = string
    gateway_id             = string
  })
  description = "specify igw or vpg"
  default     = null
}

variable "name" {
  type = string
}

variable "ipv6_cidr_block" {
  type    = string
  default = null
}
