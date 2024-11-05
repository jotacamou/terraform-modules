resource "google_project_iam_member" "iam-member" {
  for_each = {
    for k, val in local.logged : k => val
    if try(var.overrides[k].enabled, true)
  }

  project = var.project
  role    = var.iam_role
  member  = google_logging_project_sink.sinks[each.key].writer_identity
}
