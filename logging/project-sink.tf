resource "google_logging_project_sink" "bucket_sink" {
  for_each = {
    for k, val in local.logged : k => val
    if(try(var.overrides[k].enabled, true)) && (try(!var.overrides.pci, false))
  }

  project                = var.project
  name                   = each.key
  destination            = local.logged[each.key].destination
  filter                 = local.logged[each.key].filter
  unique_writer_identity = true
}

resource "google_logging_project_sink" "bucket_sink_pci" {
  for_each = {
    for k, val in local.logged_pci : k => val
    if(try(var.overrides[k].enabled, true)) && (try(var.overrides.pci, false))
  }

  project                = var.project
  name                   = each.key
  destination            = local.logged_pci[each.key].destination
  filter                 = local.logged_pci[each.key].filter
  unique_writer_identity = true
}
