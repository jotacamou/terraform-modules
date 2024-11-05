/* Input variables */

variable "project" {
  type        = string
  nullable    = false
  description = "GCP project"
  validation {
    condition = contains([
      "internal-1-4825",
      "shared-1098",
      "graphql-services-e5ba",
      "dave-173321",
      "sombra-6662",
    ], var.project)
    error_message = "Datastream is not set up to run in ${var.project} yet, please reach out to the DE team in #data_support ..."
  }
}

variable "gcs_connection_profile_id" {
  type        = string
  nullable    = false
  description = "GCS destination connection profile"
}

variable "mysql_conn" {
  type = object({
    instance = string
    database = string
    user     = optional(string, "datastream")
  })
  nullable    = false
  description = "Struct for mysql Instance and Database"
}

variable "mysql_tables" {
  type        = list(string)
  nullable    = true
  default     = []
  description = "List of tables to include in the source config - if null includes"
}

variable "mysql_tables_exclude_backfill" {
  type        = list(string)
  nullable    = true
  default     = []
  description = "List of tables to include - if null this will backfill ALL tables"
}

variable "stream_num" {
  type        = string
  nullable    = true
  default     = "01"
  description = "Stream number: zero padded two digit numeric string."
}
