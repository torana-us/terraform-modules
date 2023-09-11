
variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = set(string)
}

variable "parameter_name" {
  type = string
}

variable "vpc_endpoint_enabled" {
  type    = bool
  default = true
}
