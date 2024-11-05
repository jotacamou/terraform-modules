resource "google_logging_project_exclusion" "logging-exclusion" {
  for_each = {
    for k, val in local.exclusions : k => val
    if try(var.overrides[k].standard_exclusion, true)
  }

  project     = var.project
  name        = each.key
  description = "Exclude (${each.key}) logs"
  filter      = local.exclusions[each.key].filter
}
