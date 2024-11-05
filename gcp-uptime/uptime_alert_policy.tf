locals {

  // Public endpoints only
  // Generate the filter based on the template file and check_id from the uptime check config
  template_path = "${path.module}/filter_templates/http_uptime_check.tftpl"
  check_id      = google_monitoring_uptime_check_config.hosts_uptime_check.uptime_check_id
  filter        = templatefile(local.template_path, { uptime_check_id = local.check_id })


  // display_name is optional, if not set, use the host name
  d_name = var.display_name != null ? var.display_name : var.host

}

output "test" {
  value = local.check_id
}

resource "google_monitoring_alert_policy" "uptime_checks_alert_policy" {
  // Terraform version of if create_alert_policy = true
  count = var.create_alert_policy ? 1 : 0

  combiner              = "OR"
  display_name          = "[UPTIME ALERT] ${local.d_name}"
  enabled               = var.enable_alert
  notification_channels = var.notification_channels
  severity              = var.severity

  // Currently only set to the mgmt project
  project     = var.monitoring_project_id
  user_labels = var.user_labels

  conditions {
    display_name = "[UPTIME ALERT] ${local.d_name}"

    condition_threshold {
      comparison = "COMPARISON_GT"
      duration   = "60s"
      filter     = local.filter

      threshold_value = 1

      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields = [
          "resource.label.*",
        ]
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }

      trigger {
        count   = 1
        percent = 0
      }
    }
  }

  timeouts {}
}

