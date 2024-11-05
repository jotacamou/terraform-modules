/**
 * Data sources ~
 */

data "google_compute_default_service_account" "gce-sa" {
  project = var.project
}
