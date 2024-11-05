# terraform/modules/k8s-monitoring

## Example Usage

```hcl
module "k8s-monitoring" {
  # Ensure this path is correct from the location you are referencing the module
  source            = "./../../../modules/k8s-monitoring"
  project           = "internal-1-4825"
  cluster           = "general-1"
  scaleUpChannels   = [google_monitoring_notification_channel.slack-sre-alerts.name]
  scaleDownChannels = [google_monitoring_notification_channel.slack-sre-alerts.name]

  # If you prefer to disable these, you must set the value enabled = false on each of the monitor types
  overrides = {
    scale-down-error = {
      enabled = false
    }
  }
}
```

Since `overrides.scale-*-error.enabled=false` removes the underliying resources,
we might want to use the `scaleUpEnabled` and `scaleDownEnabled` boolean variables to
disable the alerts without deleting them. By default both of them are set to `true`.

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | 1.2.6     |
| google    | 4.4.0     |

## Providers

| Name   | Version |
|--------|---------|
| google | 4.4.0   |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | Name of the project that this will be used to monitor | `string` | n/a | yes |
| cluster | Name of the cluster that this will be used to monitor | `string` | n/a | yes |

## Outputs
