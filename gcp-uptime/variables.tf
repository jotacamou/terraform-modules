variable "monitoring_project_id" {
  description = "The ID of the project where the check will be created, defaults to mgmt project"
  type        = string
  default     = "sre-mgmt-1"
}

variable "project_id" {
  description = "The ID of the project in which the resources belong"
  type        = string
  default     = "sre-mgmt-1"
}

variable "region" {
  description = "The region in which the resources should be created"
  type        = string
  default     = "us-central1"
}

variable "display_name" {
  description = "The optional display name of the check, it overrides the default var.host"
  type        = string
  default     = null
}

variable "host" {
  description = "The host to be checked"
  type        = string
}

variable "check_interval" {
  description = "How often the check will be performed"
  type        = string
  default     = "60s"
}

variable "check_source_regions" {
  description = "The regions from which the check will be performed, empty means global"
  type        = list(string)
  default     = ["USA_OREGON", "USA_IOWA", "USA_VIRGINIA"]
}

variable "timeout" {
  description = "The timeout for the check"
  type        = string
  default     = "10s"
}

variable "user_labels" {
  description = "User-defined labels for this check"
  type        = map(string)
}

variable "content_matchers" {
  description = "A content matcher for the check"
  type = object({
    content = string
    matcher = string
  })
}

variable "http_check" {
  description = "The HTTP check configuration requiered only if tcp_check is not se, mutually exclusive"
  type        = any
  default     = null
}

variable "tcp_check" {
  description = "The TCP check configuration requiered only if http_check is not set, mutually exclusive"
  type        = any
  default     = null
}

variable "create_alert_policy" {
  description = "Whether to create an alert policy for the check"
  type        = bool
  default     = false
}

variable "enable_alert" {
  description = "Whether to enable the alert policy, alert remains created but does not notify"
  type        = bool
  default     = true
}

variable "severity" {
  description = "The severity of the alert policy"
  type        = string
  default     = "CRITICAL"
}

variable "notification_channels" {
  description = "The notification channels to be notified when the check fails"
  type        = list(string)
  default     = []
}
