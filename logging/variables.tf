variable "central_project" {
  type        = string
  description = "Project name for these logging resources"
  default     = "shared-1098"
}

variable "project" {
  type        = string
  description = "Project name for these logging resources"
}

variable "iam_role" {
  type        = string
  description = "The role used to access the logs"
  default     = "roles/logging.bucketWriter"
}

variable "unique_writer_identity" {
  type        = bool
  description = "Determines if the writer should use a unique identity"
  default     = true
}

variable "disabled" {
  type        = bool
  description = "Determines if the sink should be disabled"
  default     = false
}

variable "overrides" {
  default = {}
}
