resource "google_monitoring_uptime_check_config" "hosts_uptime_check" {
  display_name = var.display_name != null ? var.display_name : var.host

  // Check interval
  period  = var.check_interval
  project = var.monitoring_project_id

  // [] (empty) for Global
  selected_regions = var.check_source_regions
  timeout          = var.timeout

  user_labels = var.user_labels

  content_matchers {
    content = var.content_matchers.content
    matcher = var.content_matchers.matcher
  }

  // Validates if the check is HTTP or TCP
  // If it's HTTP, then create the http_check block
  dynamic "http_check" {
    for_each = var.http_check != null ? [var.http_check] : []
    content {
      headers        = http_check.value.headers
      mask_headers   = http_check.value.mask_headers
      path           = http_check.value.path
      port           = http_check.value.port
      request_method = http_check.value.request_method
      use_ssl        = http_check.value.use_ssl
      validate_ssl   = http_check.value.validate_ssl
    }
  }

  // If it's TCP, then create the tcp_check block
  dynamic "tcp_check" {
    for_each = var.tcp_check != null ? [var.tcp_check] : []
    content {
      port = tcp_check.value.port
    }
  }
  // End of check type validation

  monitored_resource {
    labels = {
      "host"       = var.host
      "project_id" = var.monitoring_project_id
    }
    type = "uptime_url"
  }

  timeouts {}
}


