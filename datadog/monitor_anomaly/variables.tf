variable "message" {
  type = string
}

variable "name" {
  type = string
}

variable "metric_query" {
  type = string
}

variable "alert_window" {
  type = object({
    num  = number
    unit = string
  })
  validation {
    condition     = var.alert_window.num > 0
    error_message = "num > 0"
  }
  validation {
    condition     = var.alert_window.unit == "m" || var.alert_window.unit == "h" || var.alert_window.unit == "d" || var.alert_window.unit == "w"
    error_message = "m, h, d or w"
  }
}

variable "algorithm" {
  type = string
  validation {
    condition     = var.algorithm == "basic" || var.algorithm == "agile" || var.algorithm == "robust"
    error_message = "basic or agile or robust"
  }
}

variable "deviations" {
  type    = number
  default = 2
  validation {
    condition     = var.deviations > 0
    error_message = "deviations > 0"
  }
  description = "controls the sensitivity of the anomaly detection."
}

variable "direction" {
  type = string
  validation {
    condition     = var.direction == "above" || var.direction == "below" || var.direction == "both"
    error_message = "above, below or both"
  }
}

variable "seasonality" {
  type    = string
  default = "daily"
  validation {
    condition     = var.seasonality == "hourly" || var.seasonality == "daily" || var.seasonality == "weekly"
    error_message = "hourly, daily, or weekly. Exclude this parameter when using the basic algorithm."
  }
}

variable "monitor_thresholds" {
  type = object({
    critical          = string
    critical_recovery = optional(string)
    ok                = optional(string)
    unknown           = optional(string)
    warning           = optional(string)
    warning_recovery  = optional(string)
  })
  default = null
}

variable "tags" {
  type    = set(string)
  default = []
}
