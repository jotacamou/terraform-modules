/* Fixed data sources */

# Consumer project is either internal-1 (staging) or datasci (production)
data "google_project" "consumer" {
  project_id = contains(["internal-1-4825"], var.project) ? var.project : "datasci-10a8"
}
