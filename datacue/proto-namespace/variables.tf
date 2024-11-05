/* Input variables */

variable "project" {
  type        = string
  nullable    = false
  description = "GCP project"
}

variable "namespace" {
  type        = string
  nullable    = false
  description = "Namespace for Datacue messages"
  validation {
    condition     = length(split(".", var.namespace)) == 1
    error_message = "Namespace must not include periods ..."
  }
}

variable "publishers" {
  type        = list(string)
  nullable    = true
  default     = []
  description = "List of users/SAs to get publish privileges on topic"
}
