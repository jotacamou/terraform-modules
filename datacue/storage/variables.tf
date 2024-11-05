/**
 * Input variables ~
 */

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

# Buckets map - keep this static @ the project level:

variable "buckets" {
  type        = map(string)
  description = "Maps project to bucket - this makes sure datacue pipelines only write to one bucket ..."
  default = {
    # "dave-173221"           = "dave-legacy-datacue" # Let's avoid if possible
    "internal-1-4825"       = "dave-internal-datacue"
    "datasci-10a8"          = "dave-datasci-datacue"
    "shared-1098"           = "dave-shared-datacue"
    "graphql-services-e5ba" = "dave-graphql-datacue"
  }
}

# Snowflake:

variable "snowflake-pubsub-sa" {
  description = "Snowflake's Pub/Sub Service Account for Dave's qc63563 account"
  type        = string
  default     = "xyuurbtibi@sfc-prod1-1-lu5.iam.gserviceaccount.com"
}
