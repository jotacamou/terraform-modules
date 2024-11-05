data "terraform_remote_state" "collectors" {
  backend = "gcs"

  config = {
    bucket = "sre-tf-state-1"
    prefix = "providers/sumologic/collectors"
  }
}
