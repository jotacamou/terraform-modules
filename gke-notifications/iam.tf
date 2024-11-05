data "google_project" "project" {
  project_id = var.project_id
}
resource "google_project_iam_member" "iam_token_creator_pubsub" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_service_account" "gke_cluster_notifications" {
  project      = var.project_id
  account_id   = "gke-cluster-notifications"
  display_name = "GKE Cluster Notifications"
}
