locals {
  critical = regex("(?:<|<=|>|>=|==|!=).*?(?P<critical>\\d+)", var.query).critical
}

resource "datadog_monitor" "this" {
  type                   = "log alert"
  query                  = trimspace(var.query)
  groupby_simple_monitor = var.groupby_simple_monitor
  evaluation_delay       = var.evaluation_delay
  new_group_delay        = var.new_group_delay

  monitor_thresholds {
    critical          = local.critical
    critical_recovery = try(var.monitor_thresholds.critical_recovery, null)
    ok                = try(var.monitor_thresholds.ok, null)
    unknown           = try(var.monitor_thresholds.unknown, null)
    warning           = try(var.monitor_thresholds.warning, null)
    warning_recovery  = try(var.monitor_thresholds.warning_recovery, null)
  }

  timeout_h            = var.timeout_h
  name                 = var.name
  message              = var.message
  enable_logs_sample   = var.enable_logs_sample
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
}

