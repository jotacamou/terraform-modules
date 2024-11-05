resource "google_pubsub_topic" "topics" {
  for_each = {
    for k, val in local.logged : k => val
    if try(var.overrides[k].enabled, true)
  }

  name         = each.key
  project      = var.project
  kms_key_name = var.kms_key_name

  timeouts {}
  labels = {
    "team" = "sre"
    "env"  = var.project == "internal-1-4825" || var.project == "devel-bad0" ? "staging" : "production"
  }
}
