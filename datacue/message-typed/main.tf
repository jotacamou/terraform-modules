/**
 * DataCue Infra Module for Incoming Message Queue ~
 */

terraform {
  required_version = "1.2.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.41.0"
    }
  }

}

locals {
  namespace = split(".", var.name)[0]
  type      = split(".", var.name)[1]
}

# Incoming message topic:

resource "google_pubsub_schema" "datacue-ingestion" {
  project    = var.project
  name       = "datacue-${local.namespace}-${local.type}"
  type       = var.schema.type
  definition = var.schema.definition
}

resource "google_pubsub_topic" "datacue-ingestion" {
  project                    = var.project
  name                       = "datacue-${local.namespace}-${local.type}"
  message_retention_duration = "604800s"
  depends_on = [
    google_pubsub_schema.datacue-ingestion,
  ]
  schema_settings {
    schema   = google_pubsub_schema.datacue-ingestion.id
    encoding = "JSON"
  }
}

resource "google_pubsub_topic_iam_binding" "datacue-ingestion-publisher" {
  project = google_pubsub_topic.datacue-ingestion.project
  topic   = google_pubsub_topic.datacue-ingestion.name
  role    = "roles/pubsub.publisher"
  members = var.publishers
}

# Incoming message subscription:

resource "google_pubsub_subscription" "datacue-ingestion" {
  project                      = google_pubsub_topic.datacue-ingestion.project
  topic                        = google_pubsub_topic.datacue-ingestion.name
  name                         = "datacue-${local.namespace}-${local.type}-dataflow"
  ack_deadline_seconds         = 600
  message_retention_duration   = "604800s"
  enable_exactly_once_delivery = false # Dataflow de-dupes already
  retain_acked_messages        = true  # For replaying
  expiration_policy {
    ttl = ""
  }
}

resource "google_pubsub_subscription_iam_binding" "datacue-ingestion-subscriber" {
  project      = google_pubsub_subscription.datacue-ingestion.project
  subscription = google_pubsub_subscription.datacue-ingestion.name
  role         = "roles/pubsub.subscriber"
  members = [
    # Dataflow reads from subscription
    "serviceAccount:${data.google_compute_default_service_account.gce-sa.email}",
  ]
}
