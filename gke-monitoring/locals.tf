locals {
  levels = {
    warning = {
      name = "Warning"
      queries = [
        <<-EOT
        resource.type="k8s_cluster"
        resource.labels.cluster_name="${var.cluster}"
        logName="projects/${var.project}/logs/container.googleapis.com%2Fcluster-autoscaler-visibility"

        (
         # scale up
         jsonPayload.noDecisionStatus.noScaleUp.unhandledPodGroups.rejectedMigs:*
         OR
         jsonPayload.noDecisionStatus.noScaleUp.skippedMigs:*
         OR
         # scale down
         jsonPayload.resultInfo.results.errorMsg.messageId:"scale.down.error."
         OR
         jsonPayload.noDecisionStatus.noScaleDown.nodes.reason.messageId="no.scale.down.node.no.place.to.move.pods"
         OR
         jsonPayload.noDecisionStatus.noScaleDown.nodes.reason.messageId="no.scale.down.node.pod.not.backed.by.controller"
         OR
         jsonPayload.noDecisionStatus.noScaleDown.nodes.reason.messageId="no.scale.down.node.pod.has.local.storage"
         OR
         jsonPayload.noDecisionStatus.noScaleDown.nodes.reason.messageId="no.scale.down.node.pod.kube.system.unmovable"
         OR
         jsonPayload.noDecisionStatus.noScaleDown.nodes.reason.messageId="no.scale.down.node.pod.controller.not.found"
         OR
         jsonPayload.noDecisionStatus.noScaleDown.nodes.reason.messageId="no.scale.down.node.pod.unexpected.error"
        )
        EOT
      ]
    }
    critical = {
      name = "Critical"
      queries = [
        <<-EOT
        resource.type="k8s_cluster"
        resource.labels.cluster_name="${var.cluster}"
        logName="projects/${var.project}/logs/container.googleapis.com%2Fcluster-autoscaler-visibility"

        (
         jsonPayload.resultInfo.results.errorMsg.messageId:"scale.up.error."
         OR
         jsonPayload.noDecisionStatus.noScaleUp.unhandledPodGroups.rejectedMigs.reason.messageId="no.scale.up.mig.failing.predicate"
        )
        AND NOT
        (
         jsonPayload.noDecisionStatus.noScaleUp.unhandledPodGroups.rejectedMigs.reason.parameters=~"^(TaintToleration|InterPodAffinity|NodeAffinity)$"
         OR
         jsonPayload.noDecisionStatus.noScaleUp.unhandledPodGroups.rejectedMigs.reason.parameters="pod has unbound immediate PersistentVolumeClaims"
        )
        EOT
        ,
        <<-EOT
        resource.type="k8s_cluster"
        resource.labels.cluster_name="${var.cluster}"

        jsonPayload.reason="ScaleUpFailed"
        EOT
      ]
    }
  }
}
