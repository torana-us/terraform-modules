variable "name" {
  type = string
}

variable "policy_arns" {
  type = set(string)
}

variable "service_list" {
  type    = set(string)
  default = []
}

variable "aws_list" {
  type    = set(string)
  default = []
}

variable "service_condition_list" {
  type = list(object({
    test     = string,
    variable = string,
    values   = set(string)
  }))
  default = []
}

variable "aws_condition_list" {
  type = list(object({
    test     = string,
    variable = string,
    values   = set(string)
  }))
  default = []
}

variable "custom_assume_policy_jsons" {
  type    = list(string)
  default = []
}

variable "max_session_duration" {
  type    = number
  default = (1 * 60 * 60)
}
