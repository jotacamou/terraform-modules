locals {
  logged = {
    # export-cloud-armor-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV3Rb1m9y8X_dO5SEFLE16yFqfn_lXYBxYCScMh7KJnSYsxau349ZirBfXuiSugn1B2grDk3Hb2tct_pZWofUT54O2tgCsM1_6rm0UUWiHsJAg==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-cloud-armor-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="http_load_balancer"
    #     ("enforcedSecurityPolicy" OR "previewSecurityPolicy")
    #     logName = "projects/${var.project}/logs/requests" AND sample(insertId, 0.50)
    #     -(httpRequest.requestUrl="https://api.trydave.com/v1/bank/plaid_webhook" (httpRequest.remoteIp="52.21.26.131" OR httpRequest.remoteIp="52.21.47.157" OR httpRequest.remoteIp="52.41.247.19" OR httpRequest.remoteIp="52.88.82.239"))
    #     -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
    #   EOT
    # },
    # export-firewall-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV3YmPk-dzkk6b2nNH-gCFzY1KzdRU4JWOT0Uz0Casw2D3NTj8d4jr9idLuXvs0fzfFQjNfUr5WUrX70hizwbSqXr7RtmTl6uXTxL7-n9Mos6g==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-firewall-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="gce_subnetwork"
    #     logName="projects/${var.project}/logs/compute.googleapis.com%2Ffirewall"
    #     (jsonPayload.rule_details.reference="network:default/firewall:internal-all" OR
    #     (NOT ip_in_net(jsonPayload.connection.src_ip, "10.0.0.0/8")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "35.191.0.0/16")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "130.211.0.0/22")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "209.85.152.0/22")))
    #   EOT
    # },
    # export-gce-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV2MydQ2_QSRubPAE31Ze5aq6cTGbonr-Ax3hjMtsOtyckjwSvMV0yTvP9MGzv1VYKZBZItiMvthaOE0smP4D35-1QINfzOPrgRbqUpwVWZPdw==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-gce-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="gce_instance"
    #     logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Fdata_access"
    #   EOT
    # },
    # export-gcr-logs-to-sumologic = {
    #   endpoint    = data.terraform_remote_state.collectors.outputs.gcr_gcp_source_url
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-gcr-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="gcs_bucket"
    #     resource.labels.bucket_name="us.artifacts.${var.project}.appspot.com"
    #     protoPayload.methodName="storage.objects.create" OR "storage.objects.delete"
    #     log_name="projects/${var.project}/logs/cloudaudit.googleapis.com%2Fdata_access"
    #   EOT
    # },
    # export-gsm-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV0um1Ntp0SqfR438vZhVnljumvQTjizubHp84paG-S6wP0D-XcmAUmTta8Qi8oZ5gYlKkUgy5V8P8Tvfo08gkmnxr-FyvgbHLTPeqrN1E-Nhg==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-gsm-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="audited_resource"
    #     protoPayload.authorizationInfo.resourceAttributes.type:"secretmanager.googleapis.com"
    #     logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Fdata_access"
    #   EOT
    # },
    # export-iam-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV2Nzk04SN-9yS0p9VBdcQLhEsU0Wu-D6GcZyS-3NuzhK2d7bjRMjQgaoZ-YiB7PKZJ_d_8XGGu0BYmNt0_FBQf8PXueRcrJhUzuqMstaOFujg==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-iam-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="project"
    #     logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Fdata_access"
    #   EOT
    # },
    # export-ids-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV37xDynt5DGcoijCWysZyFoqotpZAJvX53Tj8kg7_rmVMqdTDSMJU4873eFeokUovJIdHeRAbivoPUXPB_rBfiq0Z0H3hJC98VcWQl3OPs0AA==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-ids-logs-to-sumologic"
    #   filter      = <<-EOT
    #     logName="projects/${var.project}/logs/ids.googleapis.com%2Fthreat"
    #     NOT ip_in_net(jsonPayload.source_ip_address, "10.0.0.0/8")
    #     NOT ip_in_net(jsonPayload.source_ip_address, "35.191.0.0/16")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "130.211.0.0/22")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "209.85.152.0/22")
    #   EOT
    # },
    # export-vpc-logs-to-sumologic = {
    #   endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV0tEW8PjgGE0_sI0VHpdYa-FHXYhg3i8x79_wlEolQgJSikHnZ7JRb9bZA2fvjYWQH-ZbfFDWXjLuNjBS1agUqAe9Q9SAwnhHqFZKhjk0_OHQ==/"
    #   destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-vpc-logs-to-sumologic"
    #   filter      = <<-EOT
    #     resource.type="gce_subnetwork"
    #     jsonPayload.dest_vpc.vpc_name="default"
    #     logName="projects/${var.project}/logs/compute.googleapis.com%2Fvpc_flows" AND sample(insertId, 0.50)
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "10.0.0.0/8")
    #     NOT ip_in_net(jsonPayload.source_ip_address, "10.0.0.0/8")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "35.191.0.0/16")
    #     NOT ip_in_net(jsonPayload.source_ip_address, "35.191.0.0/16")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "130.211.0.0/22")
    #     NOT ip_in_net(jsonPayload.source_ip_address, "130.211.0.0/22")
    #     NOT ip_in_net(jsonPayload.connection.src_ip, "209.85.152.0/22")
    #     NOT ip_in_net(jsonPayload.source_ip_address, "209.85.152.0/22")
    #     -jsonPayload.bytes_sent="0"
    #   EOT
    # },

    export-lb-logs-to-sumologic = {
      endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV1tvABlfR-l7-PGlewrzBWKkWZPZZgMVz1ru9VE8rZkrRkv-BROlOBshKqTujCJFl2KtvAuJeCJ6Bjai2FOVH08FJa7yMOY6EXL7b4z6i7PYA==/"
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-lb-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="http_load_balancer"
        NOT ("enforcedSecurityPolicy" OR "previewSecurityPolicy")
        logName = "projects/${var.project}/logs/requests" AND sample(insertId, 0.50)
        -(httpRequest.requestUrl="https://api.trydave.com/v1/bank/plaid_webhook" (httpRequest.remoteIp="52.21.26.131" OR httpRequest.remoteIp="52.21.47.157" OR httpRequest.remoteIp="52.41.247.19" OR httpRequest.remoteIp="52.88.82.239"))
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
      EOT
    },
    export-cloud-function-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.cloud_function_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-cloud-function-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="cloud_function"
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
        NOT severity="DEBUG"
      EOT
    },
    export-vertex-ai-endpoint-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.vertexai_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-vertex-ai-endpoint-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="aiplatform.googleapis.com/Endpoint" AND sample(insertId, 0.05)
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
      EOT
    },
    export-vertex-ai-custom-training-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.vertexai_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-vertex-ai-custom-training-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="ml_job" AND sample(insertId, 0.05)
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
      EOT
    },
    export-vertex-ai-automl-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.vertexai_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-vertex-ai-automl-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="cloudml_job" AND sample(insertId, 0.05)
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
      EOT
    },
    export-cloudsql-logs-to-sumologic = {
      endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV1OEjk321paK0VIX5PAgNEINNoaYxANC6fBgRwn2pDI2Ch_CIqukqBb1vqrL4tWscs2JwL_7D7jL390RMo4IGu4c3g6PGqnaItj2L6K2nOUag==/"
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-cloudsql-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="cloudsql_database"
        logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Fdata_access"
        OR logName="projects/${var.project}/logs/cloudsql.googleapis.com%2Fmysql-slow.log"
        OR logName="projects/${var.project}/logs/cloudsql.googleapis.com%2Fmysql.err"
      EOT
    },
    export-nat-gw-logs-to-sumologic = {
      endpoint    = "https://endpoint6.collection.us2.sumologic.com/receiver/v1/http/ZaVnC4dhaV1fxj2vT-02KS_-BV_b5ndmv1OQIaG8ARHgY7mZjG8S_TYcnMPDdzg3Nm5E0sKSUiIG-G3yZTKehuhOuZe_hKw0Mv3DY5UAsDd-UtS2NudE2Q==/"
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-nat-gw-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="nat_gateway"
        jsonPayload.allocation_status="DROPPED"
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
      EOT
    },
    export-spanner-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.spanner_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-spanner-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="spanner_instance" AND sample(insertId, 0.05)
        NOT severity="DEBUG"
        NOT severity="INFO"
        -logName="projects/${var.project}/logs/cloudaudit.googleapis.com%2Factivity"
      EOT
    },
    export-bigtable-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.bigtable_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-bigtable-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="audited_resource"
        resource.labels.service="bigtable.googleapis.com" AND sample(insertId, 0.05)
      EOT
    },
    export-monitoring-logs-to-sumologic = {
      endpoint    = data.terraform_remote_state.collectors.outputs.monitoring_gcp_source_url
      destination = "pubsub.googleapis.com/projects/${var.project}/topics/export-monitoring-logs-to-sumologic"
      filter      = <<-EOT
        resource.type="audited_resource"
        resource.labels.service="monitoring.googleapis.com" AND sample(insertId, 0.05)
      EOT
    },
  }
}
