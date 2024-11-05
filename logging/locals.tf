locals {
  logged = {
    export-container-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-bucket-non-pci}"
      filter      = <<-EOT
(resource.type=("k8s_container" OR "k8s_pod")
-(resource.labels.namespace_name="kube-system" OR
resource.labels.cluster_name="gha-runners-1" OR
resource.labels.namespace_name="sys" OR
resource.labels.namespace_name="twingate-connector")) OR
(resource.type=("k8s_container" OR "k8s_pod")
((resource.labels.namespace_name="kube-system" AND sample(insertId, 0.10)) OR
(resource.labels.cluster_name="gha-runners-1" AND sample(insertId, 0.10)) OR
(resource.labels.namespace_name="sys" AND sample(insertId, 0.10)) OR
(resource.labels.namespace_name="twingate-connector" AND sample(insertId, 0.10))))
      EOT
    }
    export-cloudfunction-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-cloudfunction-bucket-non-pci}"
      filter      = <<-EOT
           resource.type=("cloud_function" OR "cloud_run_revision") AND sample(insertId, 0.10)
         EOT
    }
    export-cloudsql-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-cloudsql-bucket-non-pci}"
      filter      = <<-EOT
            resource.type="cloudsql_database" AND sample(insertId, 0.10)
          EOT
    }
    export-load-balancer-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-loadbalancer-bucket-non-pci}"
      filter      = <<-EOT
            resource.type="http_load_balancer" AND sample(insertId, 0.10)
          EOT
    }
    export-spanner-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-spanner-bucket-non-pci}"
      filter      = <<-EOT
            resource.type="spanner_instance" AND sample(insertId, 0.10)
          EOT
    }
  }
  logged_pci = {
    export-container-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-bucket-pci}"
      filter      = <<-EOT
(resource.type=("k8s_container" OR "k8s_pod")
-(resource.labels.namespace_name="kube-system" OR
resource.labels.cluster_name="gha-runners-1" OR
resource.labels.namespace_name="sys" OR
resource.labels.namespace_name="twingate-connector")) OR
(resource.type=("k8s_container" OR "k8s_pod")
((resource.labels.namespace_name="kube-system" AND sample(insertId, 0.10)) OR
(resource.labels.cluster_name="gha-runners-1" AND sample(insertId, 0.10)) OR
(resource.labels.namespace_name="sys" AND sample(insertId, 0.10)) OR
(resource.labels.namespace_name="twingate-connector" AND sample(insertId, 0.10))))
      EOT
    }
    export-cloudfunction-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-cloudfunction-bucket-pci}"
      filter      = <<-EOT
            resource.type=("cloud_function" OR "cloud_run_revision") AND sample(insertId, 0.10)
          EOT
    }
    export-cloudsql-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-cloudsql-bucket-pci}"
      filter      = <<-EOT
            resource.type="cloudsql_database" AND sample(insertId, 0.10)
          EOT
    }
    export-load-balancer-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-loadbalancer-bucket-pci}"
      filter      = <<-EOT
            resource.type="http_load_balancer" AND sample(insertId, 0.10)
          EOT
    }
    export-spanner-logs-to-central-location = {
      destination = "logging.googleapis.com/${data.terraform_remote_state.storage.outputs.gcp-logging-spanner-bucket-pci}"
      filter      = <<-EOT
            resource.type="spanner_instance" AND sample(insertId, 0.10)
          EOT
    }
  }
  exclusions = {
    export-container-logs-to-central-location = {
      filter = <<-EOT
        resource.type=("k8s_container" OR "k8s_pod")
      EOT
    }
    export-cloudfunction-logs-to-central-location = {
      filter = <<-EOT
            resource.type=("cloud_function" OR "cloud_run_revision")
          EOT
    }
    export-cloudsql-logs-to-central-location = {
      filter = <<-EOT
            resource.type="cloudsql_database"
          EOT
    }
    export-load-balancer-logs-to-central-location = {
      filter = <<-EOT
            resource.type="http_load_balancer"
          EOT
    }
    export-spanner-logs-to-central-location = {
      filter = <<-EOT
            resource.type="spanner_instance"
          EOT
    }
  }
}
