resource "google_pubsub_topic" "gke_cluster_notifications" {
  name = var.topic_name

  labels = tomap({
    env  = "staging"
    team = "sre"
  })

  project = var.project_id
}

resource "google_pubsub_subscription" "gke_cluster_notifications" {
  name = var.subscription_name

  labels = tomap({
    env  = "staging"
    team = "sre"
  })

  project                    = var.project_id
  topic                      = google_pubsub_topic.gke_cluster_notifications.name
  message_retention_duration = "604800s" # default is 7 days
  ack_deadline_seconds       = 10        # default is 10s

  push_config {
    push_endpoint = var.push_endpoint
    oidc_token {
      service_account_email = var.service_account_email
      audience              = var.push_endpoint
    }
  }

  depends_on = [google_service_account.gke_cluster_notifications]
}
