/* DataCue/SnowBurst Infra Module */

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
  # BOTH dataflow SAs need access to the subscription
  dataflow = [
    "serviceAccount:${data.google_project.consumer.number}-compute@developer.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.consumer.number}@dataflow-service-producer-prod.iam.gserviceaccount.com",
  ]
}

# Incoming message topic:
resource "google_pubsub_topic" "datacue-ingestion" {
  project                    = var.project
  name                       = "datacue-${var.namespace}"
  message_retention_duration = "604800s"
  labels = {
    serialization = "protobuf"
  }
}

resource "google_pubsub_topic_iam_member" "datacue-ingestion-publisher" {
  for_each = toset(var.publishers)
  project  = google_pubsub_topic.datacue-ingestion.project
  topic    = google_pubsub_topic.datacue-ingestion.name
  role     = "roles/pubsub.publisher"
  member   = each.value
}

# Incoming message subscription:
resource "google_pubsub_subscription" "datacue-ingestion" {
  project                      = data.google_project.consumer.project_id
  topic                        = "projects/${var.project}/topics/${google_pubsub_topic.datacue-ingestion.name}"
  name                         = "datacue-snowburst-${var.namespace}"
  ack_deadline_seconds         = 600
  message_retention_duration   = "604800s"
  enable_exactly_once_delivery = false # Dataflow de-dupes already
  retain_acked_messages        = true  # For replaying
  expiration_policy {
    ttl = ""
  }
  labels = {
    serialization = "protobuf"
    src           = var.project
  }
}

resource "google_pubsub_subscription_iam_member" "datacue-ingestion-subscriber" {
  for_each     = toset(local.dataflow)
  project      = data.google_project.consumer.project_id
  subscription = google_pubsub_subscription.datacue-ingestion.name
  role         = "roles/pubsub.subscriber"
  member       = each.value
}

resource "google_pubsub_subscription_iam_member" "datacue-ingestion-viewer" {
  for_each     = toset(local.dataflow)
  project      = google_pubsub_subscription.datacue-ingestion.project
  subscription = google_pubsub_subscription.datacue-ingestion.name
  role         = "roles/pubsub.viewer"
  member       = each.value
}
