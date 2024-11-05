/**
 * Input variables ~
 */

variable "project" {
  type        = string
  nullable    = false
  description = "GCP project"
}

variable "name" {
  type        = string
  nullable    = false
  description = "Name of message <namespace>.<type>"
  validation {
    condition     = length(split(".", var.name)) == 2
    error_message = "The `name` input must be of the form <namespace>.<message-type>` ..."
  }
}

variable "schema" {
  type = object({
    type       = string
    definition = string
  })
  nullable    = false
  description = "Schema for Pub/Sub"
  validation {
    condition     = contains(["PROTOCOL_BUFFER", "AVRO"], var.schema.type)
    error_message = "Schema type can only be `PROTOCOL_BUFFER`, `AVRO` ..."
  }
}

variable "publishers" {
  type        = list(string)
  nullable    = false
  description = "List of users/SAs to get publish privileges on topic"
}
