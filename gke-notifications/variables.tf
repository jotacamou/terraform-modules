/**
 * Input variables ~
 */

variable "project_id" {
  type        = string
  description = "GCP project id"
}

variable "topic_name" {
  type        = string
  description = "Topic name"
  default     = "gke-cluster-notifications"
}

variable "subscription_name" {
  type        = string
  description = "Subscription name"
  default     = "gke-cluster-notifications"
}

variable "push_endpoint" {
  type        = string
  description = "A URL locating the endpoint to which messages should be pushed"
  default     = "https://us-central1-sre-mgmt-1.cloudfunctions.net/gke-cluster-notifications"
}

variable "service_account_email" {
  type        = string
  description = "Service account used to authenticate to the push endpoint"
}
