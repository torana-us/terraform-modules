variable "env" {
  type = string
}

variable "log_group_name_list" {
  type = set(string)
}

variable "stream_name_suffix" {
  type = string
}

variable "common_attributes_list" {
  type = set(object({
      name = string
      value = string
    }))
  default = []
}