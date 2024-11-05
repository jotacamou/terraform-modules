/**
 * DataCue Infra Module for the Storage Notification Queue ~
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

# Storage notification topic:

resource "google_pubsub_topic" "datacue-storage-notification" {
  project                    = var.project
  name                       = "datacue-storage-${var.namespace}"
  message_retention_duration = "604800s"
}

resource "google_pubsub_topic_iam_binding" "datacue-storage-notification-publisher" {
  project = google_pubsub_topic.datacue-storage-notification.project
  topic   = google_pubsub_topic.datacue-storage-notification.name
  role    = "roles/pubsub.publisher"
  members = [
    # Only the GCS SA publishes events to the topic
    "serviceAccount:${data.google_storage_project_service_account.gcs-sa.email_address}",
  ]
}

# Storage notification:

resource "google_storage_notification" "datacue-storage-notification" {
  bucket         = lookup(var.buckets, var.project)
  topic          = "projects/${var.project}/topics/${google_pubsub_topic.datacue-storage-notification.name}"
  payload_format = "JSON_API_V1"
  event_types = [
    "OBJECT_FINALIZE",
  ]
  object_name_prefix = "${var.namespace}/" # Filter storage notification to namespace prefix
}

# Storage notification subscription:

resource "google_pubsub_subscription" "datacue-snowpipe" {
  project                      = google_pubsub_topic.datacue-storage-notification.project
  topic                        = google_pubsub_topic.datacue-storage-notification.name
  name                         = "datacue-snowpipe-${var.namespace}"
  ack_deadline_seconds         = 600
  message_retention_duration   = "604800s"
  enable_exactly_once_delivery = true  # Helps avoid redundancy
  retain_acked_messages        = false # Must be false for Snowpipe to pick up messages
  expiration_policy {
    ttl = ""
  }
}

resource "google_pubsub_subscription_iam_binding" "datacue-snowpipe-subscriber" {
  project      = google_pubsub_subscription.datacue-snowpipe.project
  subscription = google_pubsub_subscription.datacue-snowpipe.name
  role         = "roles/pubsub.subscriber"
  members = [
    # Snowpipe reads storage notifications
    "serviceAccount:${var.snowflake-pubsub-sa}",
  ]
}
