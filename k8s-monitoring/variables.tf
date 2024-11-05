variable "project" {
  type        = string
  description = "Project name for these logging resources"
}

variable "cluster" {
  type        = string
  description = "The cluster to apply this monitor to"
}

variable "overrides" {
  default = {}
}

variable "scaleUpEnabled" {
  type        = bool
  description = "Determines if the scaleDown monitor should alert"
  default     = true
}

variable "scaleUpChannels" {
  type        = list(any)
  description = "List of slack, email, or pager duty notification channels to alert on"
}

variable "scaleDownEnabled" {
  type        = bool
  description = "Determines if the scaleDown monitor should alert"
  default     = true
}

variable "scaleDownChannels" {
  type        = list(any)
  description = "List of slack, email, or pager duty notification channels to alert on"
}
