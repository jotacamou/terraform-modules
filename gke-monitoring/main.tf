resource "google_monitoring_alert_policy" "gke_monitoring" {
  // Flatten the locals.levels map into a list of objects so it can be used
  // in a for_each with a unique key
  for_each = {
    for item in flatten([
      for level in local.levels : [
        for i, query in level.queries : {
          id    = "${level.name} ${sha1(query)}"
          i     = i
          name  = level.name
          query = query
        }
      ]
    ])
    : item.id => item
  }

  project      = var.project
  display_name = "gke-monitoring-${lower(each.value.name)} [${var.project}:${var.cluster}]"
  enabled      = each.value.name == "Warning" ? var.warning_enabled : var.critical_enabled

  combiner = "OR"
  conditions {
    display_name = "gke-monitoring-${lower(each.value.name)} [${var.project}:${var.cluster}]"
    condition_matched_log {
      filter = each.value.query
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "1800s"
    }
    auto_close = "1800s"
  }

  notification_channels = each.value.name == "Warning" ? var.warning_channels : var.critical_channels

}
