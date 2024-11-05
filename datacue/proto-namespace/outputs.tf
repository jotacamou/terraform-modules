/* Output variables */

output "topic" {
  value       = google_pubsub_topic.datacue-ingestion.name
  description = "Name of the DataCue message topic"
}

output "subscription" {
  value       = google_pubsub_subscription.datacue-ingestion.name
  description = "Name of the DataCue message subscription"
}

