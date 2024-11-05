/**
 * Data sources ~
 */

data "google_storage_project_service_account" "gcs-sa" {
  project = var.project
}
