# Data sources

data "google_compute_default_service_account" "gce-sa" {
  project = var.project
}

# For non-staging projects, we'll grant perms to datasc-10a8 Datafllow SAs as well
data "google_project" "consumer" {
  project_id = contains(["internal-1-4825"], var.project) ? var.project : "datasci-10a8"
}
