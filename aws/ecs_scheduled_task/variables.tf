variable "container_definitions" {
  type        = string
  description = "json"
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type    = string
  default = null
}

variable "ecs_cluster_arn" {
  type = string
}

variable "target_role_arn" {
  type        = string
  description = "be used for target when the rule is triggered."
}

variable "input" {
  type        = string
  default     = null
  description = <<EOT
  containerOverrides as json
  ref: https://docs.aws.amazon.com/cli/latest/reference/ecs/run-task.html
EOT
}

variable "platform_version" {
  type    = string
  default = "LATEST"
}

variable "security_groups" {
  type = set(string)
}

variable "subnets" {
  type = set(string)
}

variable "name" {
  type = string
}

variable "schedule_expression" {
  type        = string
  description = "cron or rate"
}

variable "event_bus_name" {
  type    = string
  default = "default"
}

variable "is_enabled" {
  type    = bool
  default = true
}

variable "dead_letter_queue_arn" {
  type    = string
  default = null
}

variable "maximum_event_age_in_seconds" {
  type        = number
  default     = 60
  description = "The age in seconds to continue to make retry attempts"
}

variable "maximum_retry_attempts" {
  type        = number
  default     = 0
  description = "maximum number of retry attempts to make before the request fails"
}
