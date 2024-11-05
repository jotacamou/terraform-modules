data "terraform_remote_state" "storage" {
  backend = "gcs"

  config = {
    bucket = "sre-tf-state-1"
    prefix = "projects/shared/storage"
  }
}
