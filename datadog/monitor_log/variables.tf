# * Define the query
variable "query" {
  type        = string
  description = "logs(query).index(index_name).rollup(rollup_method[, measure]).last(time_window) operator #"
}

variable "groupby_simple_monitor" {
  type    = bool
  default = false
}

# * Set alert conditions
variable "evaluation_delay" {
  type    = number
  default = 60
}

variable "new_group_delay" {
  type    = number
  default = null
}

variable "monitor_thresholds" {
  type = object({
    critical_recovery = optional(string)
    ok                = optional(string)
    unknown           = optional(string)
    warning           = optional(string)
    warning_recovery  = optional(string)
  })
  default = null
}

variable "timeout_h" {
  type    = number
  default = null
}

# * Notify your team
variable "name" {
  type = string
}

variable "message" {
  type = string
}

variable "enable_logs_sample" {
  type    = bool
  default = true
}

variable "escalation_message" {
  type    = string
  default = null
}

variable "include_tags" {
  type    = string
  default = false
}

variable "priority" {
  type = number
}

variable "renotify_interval" {
  type    = number
  default = null
}

variable "renotify_occurrences" {
  type    = number
  default = null
}

variable "renotify_statuses" {
  type    = set(string)
  default = []
}

variable "require_full_window" {
  type    = bool
  default = false
}

variable "tags" {
  type = set(string)
}

# * Define permissions
variable "restricted_roles" {
  type        = set(string)
  default     = []
  description = "Restrict editing of this monitor"
}

variable "notify_audit" {
  type        = bool
  default     = false
  description = "If this monitor is modified, notify"
}

variable "force_delete" {
  type        = bool
  default     = false
  description = "delete even if it’s referenced by other resources"
}
