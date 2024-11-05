resource "google_project_iam_member" "iam-member-non-pci" {
  for_each = {
    for k, val in local.logged : k => val
    if(try(var.overrides[k].enabled, true)) && (try(!var.overrides.pci, false)) && var.project != "shared-1098"
  }

  project = var.central_project
  role    = var.iam_role
  member  = google_logging_project_sink.bucket_sink[each.key].writer_identity
}

resource "google_project_iam_member" "iam-member-pci" {
  for_each = {
    for k, val in local.logged_pci : k => val
    if(try(var.overrides[k].enabled, true)) && (try(var.overrides.pci, false)) && var.project != "shared-1098"
  }

  project = var.central_project
  role    = var.iam_role
  member  = google_logging_project_sink.bucket_sink_pci[each.key].writer_identity
}
