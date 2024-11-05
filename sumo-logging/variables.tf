variable "project" {
  type        = string
  description = "Project name for these logging resources"
}

variable "iam_role" {
  type        = string
  description = "The role used to access the logs"
  default     = "roles/pubsub.publisher"
}

variable "push_endpoint" {
  type        = string
  description = "A URL locating the endpoint to which messages should be pushed"
  default     = null
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

variable "kms_key_name" {
  type        = string
  description = "KMS Key for encrypting the pub topic"
  default     = null
}

variable "message_retention_duration" {
  type        = string
  description = "How long the subscription messages should be retained in seconds"
  default     = "604800s"
}

variable "enable_message_ordering" {
  type        = bool
  description = "Determines if messages published with the same orderingKey in PubsubMessage will be delivered to the subscribers in the order in which they are received by the Pub/Sub system"
  default     = "false"
}

variable "nat_gw_logging" {
  type        = bool
  description = "Determines if log collection should happen for the NAT Gateways"
  default     = "false"
}

variable "cloudsql_logging" {
  type        = bool
  description = "Determines if log collection should happen for CloudSQL"
  default     = "false"
}

variable "overrides" {
  default = {}
}
