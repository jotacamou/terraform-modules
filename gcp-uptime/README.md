# Terraform Module for Google Monitoring Uptime Checks

This Terraform module manages a list of `google_monitoring_uptime_check_config` and `google_monitoring_alert_policy` resources.

This module is only for uptime checks of external resources.

This module creates one Uptime check configuration and one alert policy for each module.
Each module can have only one hostname.
Each alert policy must have at least one notification channel, but it can have more than one.

## Usage

```hcl
module "api-trydave-com" {
  source = "./../modules/gcp-uptime"

  host                 = "api.trydave.com"
  timeout              = "5s"
  check_source_regions = []

  http_check = {
    headers        = {}
    mask_headers   = false
    path           = "/"
    port           = 443
    request_method = "GET"
    use_ssl        = true
    validate_ssl   = true
  }
  content_matchers = {
    content = jsonencode({ ok = true })
    matcher = "CONTAINS_STRING"
  }
  user_labels = {
    "team"                   = "sre"
    "disable-on-maintenance" = "true"
  }

  create_alert_policy = true
  severity            = "CRITICAL"
  notification_channels = [
    google_monitoring_notification_channel.slack-eng-bank-notifications.name,
    google_monitoring_notification_channel.slack-alerts-temp.name,
  ]
}
```

Replace `<module-source>` with the module source and `<your-project-id>` with your Google Cloud project ID.

## Inputs

| Name | Description | Type | Required | Defaults |
|------|-------------|:----:|:--------:|:--------:|
| region | The region in which the resources should be created | string | No | "us-central1" |
| display_name | The optional display name of the check, it overrides the default var.host | string | No | null |
| host | The host to be checked | string | Yes | N/A |
| check_interval | How often the check will be performed | string | No | "60s" |
| check_source_regions | The regions from which the check will be performed, empty means global | list(string) | No | [] |
| timeout | The timeout for the check | string | No | "10s" |
| user_labels | User-defined labels for this check | map(string) | Yes | N/A |
| content_matchers | A content matcher for the check | object({content = string, matcher = string}) | Yes | N/A |
| http_check | The HTTP check configuration | any | No | null |
| tcp_check | The TCP check configuration | any | No | null |
| create_alert_policy | Whether to create an alert policy for the check | bool | No | false |
| enable_alert | Whether to enable the alert policy, alert remains created but does not notify | bool | No | true |
| notification_channels | The notification channels to be notified when the check fails | list(string) | Yes | N/A |
| severity | The severity level of the alert | string | Yes | CRITICAL |

## Resources Managed

- `google_monitoring_uptime_check_config`: This resource represents a Google Cloud Monitoring uptime check configuration.
- `google_monitoring_alert_policy`: This resource represents a Google Cloud Monitoring alert policy.

## Requierements and limitations

- Notification channel must already be on created by terraform.
- At least 1 notification channel if `create_alert_policy` is set to true
- Must define 1 of `http_check` or `tcp_check`
- There is a relationship of 1:1 on `hostname` to `alert policy` 

