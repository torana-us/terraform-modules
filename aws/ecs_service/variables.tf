variable "service_name" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "launch_type" {
  type    = string
  default = null
}

variable "platform_version" {
  type    = string
  default = null
}

variable "propagate_tags" {
  type    = string
  default = "TASK_DEFINITION"
}

variable "health_check_grace_period_seconds" {
  type = number
}

variable "load_balancers" {
  type = list(object({
    container_name   = string
    container_port   = number
    target_group_arn = string
  }))
}

variable "network_configuration" {
  type = object({
    assign_public_ip = bool
    security_groups  = set(string)
    subnets          = set(string)
  })
  description = "(optional) describe your variable"
}

variable "deployment_controller" {
  type    = string
  default = "CODE_DEPLOY"
}

variable "capacity_provider_strategies" {
  type = list(object({
    capacity_provider = string
    base              = number
    weight            = number
  }))
  default = []
}

variable "service_registries" {
  type = object({
    registry_arn   = string
    port           = number
    container_port = number
    container_name = string
  })
  default = null
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "task_name" {
  type = string
}

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
