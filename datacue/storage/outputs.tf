/**
 * Output variables ~
 */

output "topic" {
  value       = google_pubsub_topic.datacue-storage-notification.name
  description = "Name of the DataCue storage topic"
}

output "subscription" {
  value       = google_pubsub_subscription.datacue-snowpipe.name
  description = "Name of the DataCue storage subscription"
}
