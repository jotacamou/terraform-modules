variable "project" {
  type = string
}

variable "cluster" {
  type = string
}

variable "warning_enabled" {
  type        = bool
  description = "Enable warning alerts"
  default     = true
}

variable "critical_enabled" {
  type        = bool
  description = "Enable critical alerts"
  default     = true
}

variable "warning_channels" {
  type        = list(any)
  description = "List of channels to notify on warning alerts"
}

variable "critical_channels" {
  type        = list(any)
  description = "List of channels to notify on critical alerts"
}
