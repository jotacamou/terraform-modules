# terraform/modules/sumo-logging

## Example Usage

```hcl
module "sumo-logging" {
  # Ensure this path is correct from the location you are referencing the module
  source   = "./../../../modules/sumo-logging"
  project   = local.project

  # If not defined, defaults to all items in the local.logged object being setup
  overrides = {
    export-cloudsql-logs-to-sumologic = {
      enabled = false
    }
  }
}
```

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | 0.15.5    |
| google    | 4.4.0     |

## Providers

| Name   | Version |
|--------|---------|
| google | 4.4.0   |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | Name of the project that this will be used to send logs for | `string` | n/a | yes |
| iam\_role | IAM Role used to access the logs | `string` | `roles/pubsub.publisher` | no |
| push\_endpoint | A URL locating the endpoint to which messages should be pushed. | `string` | n/a | no |
| unique\_writer\_identity | Use a unique writer | `bool` | `false` | no |
| disabled | If set to true, then this sink is disabled and it does not export any log entries. | `bool` | `false` | no |
| kms\_key\_name | The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic. | `string` | `null` | no |
| message\_retention\_duration | Indicates the minimum duration to retain a message after it is published to the topic. If this field is set, messages published to the topic in the last messageRetentionDuration are always available to subscribers. For instance, it allows any attached subscription to seek to a timestamp that is up to messageRetentionDuration in the past. If this field is not set, message retention is controlled by settings on individual subscriptions. Cannot be more than 7 days or less than 10 minutes. | `string` | `604800s` | no |
| enable\_message\_ordering | Determines if messages published with the same orderingKey in PubsubMessage will be delivered to the subscribers in the order in which they are received by the Pub/Sub system | `bool` | `false` | no |
| nat\_gw\_logging | Determines if logging components should be created for the NAT gateway | `bool` | `false` | no |
| cloudsql\_logging | Determines if logging components should be created for CloudSQL | `bool` | `false` | no |

## Outputs
