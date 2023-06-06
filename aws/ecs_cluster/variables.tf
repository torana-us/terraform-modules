variable "name" {
  type = string
}

variable "container_insights_enabled" {
  type    = bool
  default = true
}

variable "default_capacity_provider_strategies" {
  type = list(object({
    capacity_provider = string
    base              = number
    weight            = number
  }))
}

variable "cluster_configuration" {
  type = object({
    execute_command_configuration = object({
      kms_key_id        = string
      logging           = string
      log_configuration = any
    })
  })
  default = null
}
