variable "cidr_block" {
  type = string
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

variable "name" {
  type = string
}
