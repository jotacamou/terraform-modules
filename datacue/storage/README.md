# DataCue Storage Notification

Module to create a storage notification Queue for a DataCue message namespace.

Storage notifications are configured at the _namespace_ level and not the _message type_ level.

This is done to simplify and opitmize the downstream Snowflake integration.

The storage notification is confgured to send
[Object Finalize](https://cloud.google.com/storage/docs/pubsub-notifications#events) events when
files land @ `gs://dave-<project>-datacue/<namespace>/`

## Example Usage

```hcl
module "datacue-typed" {
  source    = "./../../../modules/datacue/storage"
  project   = var.internal_project
  namespace = "test"
}
```

## Requirements

| Name | Version |
| -- | -- |
| terraform | 1.2.1 |
| google    | 4.4.1 |

## Providers

| Name   | Version |
|--------|---------|
| google | 4.4.0   |

## Inputs

| Name | Description | Type | Default | Required |
| -- | -- | -- | -- | -- | 
| project | GCP project | string | | Yes |
| namespace | Pub/Sub DataCue message namespace | string | | Yes |
| buckets | Maps project to bucket | map(string) | ```{"internal-1-4825" => "dave-internal-datacue", "datasci-10a8" => "dave-datasci-datacue"}``` | No |
| snowflake-pubsub-sa | Snowflake's Pub/Sub Service Account for Dave's qc63563 account" | string | `xyuurbtibi@sfc-prod1-1-lu5.iam.gserviceaccount.com` | No |

## Outputs

| Name | Description | Type | Note |
| -- | -- | -- | -- |
| topic | Name of the DataCue storage topic | string | _like_ `datacue-storage-<namespace>`|
| subscription | Name of the DataCue storage subscription | string | _like_ `datacue-snowpipe-<namespace>`|