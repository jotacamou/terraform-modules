locals {
  monitored = {
    scale-down-error = {
      filter   = <<-EOT
        resource.type="k8s_cluster"
        resource.labels.cluster_name="${var.cluster}"
        logName="projects/${var.project}/logs/container.googleapis.com%2Fcluster-autoscaler-visibility"
        "noScaleDown"
      EOT
      channels = var.scaleDownChannels
      enabled  = var.scaleDownEnabled
    },
    scale-up-error = {
      filter   = <<-EOT
        resource.type="k8s_cluster"
        resource.labels.cluster_name="${var.cluster}"
        logName="projects/${var.project}/logs/container.googleapis.com%2Fcluster-autoscaler-visibility"
        "noScaleUp"
      EOT
      channels = var.scaleUpChannels
      enabled  = var.scaleUpEnabled
    },
  }
}
