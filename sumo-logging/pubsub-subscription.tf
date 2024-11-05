resource "google_pubsub_subscription" "subscriptions" {
  for_each = {
    for k, val in local.logged : k => val
    if try(var.overrides[k].enabled, true)
  }

  name                       = each.key
  project                    = var.project
  topic                      = each.key
  message_retention_duration = var.message_retention_duration
  ack_deadline_seconds       = 10
  retain_acked_messages      = false
  enable_message_ordering    = var.enable_message_ordering

  push_config {
    push_endpoint = local.logged[each.key].endpoint
    attributes = {
      x-goog-version = "v1"
    }
  }

  expiration_policy {
    ttl = ""
  }

  labels = {
    "team" = "sre"
    "env"  = var.project == "internal-1-4825" || var.project == "devel-bad0" ? "staging" : "production"
  }

  depends_on = [google_pubsub_topic.topics]
}
