/**
 * DataCue Infra Module
 */

terraform {
  required_version = ">= 1.2.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.41.0"
    }
  }
}


locals {
  # Future DataCue/Snowburst pipelines will likely run in datasci-10a8 for production
  # Granting in the source production project AND datasci-10a8 for now
  dataflow_sas = compact(
    [
      "serviceAccount:${data.google_compute_default_service_account.gce-sa.email}",
      "serviceAccount:${data.google_project.consumer.number}-compute@developer.gserviceaccount.com",
      "serviceAccount:service-${data.google_project.consumer.number}@dataflow-service-producer-prod.iam.gserviceaccount.com",
    ]
  )
}

# Incoming message topic:

resource "google_pubsub_topic" "datacue-ingestion" {
  project                    = var.project
  name                       = "datacue-${var.namespace}"
  message_retention_duration = "604800s"
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
  name                         = var.snowburst ? "datacue-snowburst-${var.namespace}" : "datacue-${var.namespace}-dataflow"
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
  members      = local.dataflow_sas
}

resource "google_pubsub_subscription_iam_binding" "datacue-ingestion-viewer" {
  project      = google_pubsub_subscription.datacue-ingestion.project
  subscription = google_pubsub_subscription.datacue-ingestion.name
  role         = "roles/pubsub.viewer"
  members      = local.dataflow_sas
}
