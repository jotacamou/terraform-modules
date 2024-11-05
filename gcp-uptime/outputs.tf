// Outputs commented out while testing

# output "uptime_check_urls" {
#   description = "The URLs that are being monitored for uptime."
#   value       = [google_monitoring_uptime_check_config.hosts_uptime_check.*.monitored_resource.0.labels.host]
# }

# output "uptime_check_id" {
#   description = "The names of the uptime checks."
#   value       = google_monitoring_uptime_check_config.hosts_uptime_check.*.uptime_check_id
# }

# output "alert_policy_names" {
#   description = "The names of the alert policies."
#   value       = google_monitoring_alert_policy.alert_policy.*.display_name
# }
