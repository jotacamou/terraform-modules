resource "google_logging_project_sink" "sinks" {
  for_each = {
    for k, val in local.logged : k => val
    if try(var.overrides[k].enabled, true)
  }

  project                = var.project
  unique_writer_identity = var.unique_writer_identity

  name        = each.key
  description = "SumoLogic Log Export (${each.key})"
  destination = local.logged[each.key].destination
  filter      = local.logged[each.key].filter
}
