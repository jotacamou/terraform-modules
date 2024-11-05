resource "google_monitoring_alert_policy" "log_based_alert_policy" {
  for_each = {
    for k, val in local.monitored : k => val
    if try(var.overrides[k].enabled, true)
  }

  enabled      = local.monitored[each.key].enabled
  project      = var.project
  display_name = "${var.cluster}-${each.key}"
  combiner     = "OR"
  conditions {
    display_name = "${var.cluster}-${each.key}"
    condition_matched_log {
      filter = local.monitored[each.key].filter
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "1800s"
    }
    auto_close = "1800s"
  }

  notification_channels = local.monitored[each.key].channels
}
