# https://docs.datadoghq.com/monitors/types/anomaly/
locals {
  second_map = {
    "m" = 60
    "h" = 60 * 60
    "d" = 60 * 60 * 24
    "w" = 60 * 60 * 24 * 7
  }

  # Must be at least as large as the alert_window and is recommended to be around 5 times the alert_window
  query_window = "last_${var.alert_window.num * 5}${var.alert_window.unit}"
  alert_window = "last_${var.alert_window.num}${var.alert_window.unit}"
  interval     = (var.alert_window.num * local.second_map[var.alert_window.unit]) * 0.1
  query = format(
    "avg(%s):anomalies(%s, '%s', %d, direction='%s', alert_window='%s', interval=%d, count_default_zero='true' %s) >= %s",
    local.query_window,
    var.metric_query,
    var.algorithm,
    var.deviations,
    var.direction,
    local.alert_window,
    local.interval,
    var.algorithm == "basic" ? "" : ", seasonality='${var.seasonality}'",
    var.monitor_thresholds.critical
  )
}

resource "datadog_monitor" "this" {
  type    = "query alert"
  query   = local.query
  message = var.message
  name    = var.name

  monitor_threshold_windows {
    trigger_window  = local.alert_window
    recovery_window = local.alert_window
  }

  monitor_thresholds {
    critical          = var.monitor_thresholds.critical
    critical_recovery = try(var.monitor_thresholds.critical_recovery, null)
    ok                = try(var.monitor_thresholds.ok, null)
    unknown           = try(var.monitor_thresholds.unknown, null)
    warning           = try(var.monitor_thresholds.warning, null)
    warning_recovery  = try(var.monitor_thresholds.warning_recovery, null)
  }

  tags = var.tags
}
