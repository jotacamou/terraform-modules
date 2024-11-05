output "topic_name" {
  value = google_pubsub_topic.gke_cluster_notifications.name
}

output "subscription_name" {
  value = google_pubsub_subscription.gke_cluster_notifications.name
}
