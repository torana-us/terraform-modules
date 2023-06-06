variable "name" {
  type        = string
  description = "cluster_identifier"
}

variable "database_name" {
  type = string
}

variable "db_pass" {
  type = string
}

variable "db_user" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "instances" {
  type = map(object({
    performance_insights_enabled = bool
    tier                         = number
  }))
}

variable "subnet_ids" {
  type = set(string)
}

variable "subnet_group_name" {
  type = string
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "db_cluster_parameter_group_name" {
  type = string
}

variable "db_instance_parameter_group_name" {
  type = string
}

variable "port" {
  type        = number
  default     = null
  description = "given null, guess port"
}

variable "security_group_ids" {
  type = set(string)
}

variable "iam_role_arns" {
  type = set(string)
}

variable "enabled_cloudwatch_logs_exports" {
  type    = set(string)
  default = []
}
