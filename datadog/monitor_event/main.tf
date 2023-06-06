locals {
  critical = regex("(?:<|<=|>|>=|==|!=).*?(?P<critical>\\d+)", var.query).critical
  #  {"num" = ?, "unit" = ?}
  time_window = regex("(?:last\\(\")(?P<num>\\d+)(?P<unit>.)\"\\)", var.query)
  minute_map = {
    "m" = 1
    "h" = 60
    "d" = 60 * 24
    "w" = 60 * 24 * 7
  }
  time_window_minutes = local.time_window.num * local.minute_map[local.time_window.unit]
}

resource "datadog_monitor" "this" {
  type  = "event-v2 alert"
  query = var.query

  evaluation_delay     = var.evaluation_delay
  new_group_delay      = var.new_group_delay
  no_data_timeframe    = var.no_data_timeframe == null ? local.time_window_minutes * 2 : var.no_data_timeframe
  notify_no_data       = var.notify_no_data
  timeout_h            = var.timeout_h
  name                 = var.name
  message              = var.message
  escalation_message   = var.escalation_message
  include_tags         = var.include_tags
  priority             = var.priority
  renotify_interval    = var.renotify_interval
  renotify_occurrences = var.renotify_occurrences
  renotify_statuses    = var.renotify_statuses
  require_full_window  = var.require_full_window
  tags                 = var.tags
  restricted_roles     = var.restricted_roles
  notify_audit         = var.notify_audit
  force_delete         = var.force_delete

  monitor_thresholds {
    critical          = local.critical
    critical_recovery = try(var.monitor_thresholds.critical_recovery, null)
    ok                = try(var.monitor_thresholds.ok, null)
    unknown           = try(var.monitor_thresholds.unknown, null)
    warning           = try(var.monitor_thresholds.warning, null)
    warning_recovery  = try(var.monitor_thresholds.warning_recovery, null)
  }
}
