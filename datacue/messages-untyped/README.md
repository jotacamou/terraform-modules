# DataCue Version 9

Module to create an un-typed topic and a subscription for app teams to write to and Dataflow to
read from.

It's assumed that multiple messages types will flow through a topic created here.

The main benefits of this module are to enforce naming conventions, handle IAM bindings, and create
the stuff that's _needed_ but _often forget_.

## Example Usage

```hcl
module "datacue-messages-test" {
  source    = "./../../../modules/datacue/messages-untyped"
  project   = var.internal_project
  namespace = "test"
  publishers = [
    "group:data-eng@dave.com",
  ]
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
| name| Pub/Sub DataCue message name, must be like `<namespace>.<type>` | string | | Yes |
| publishers | Namespace for messages | list(string) | | Yes |


## Outputs

| Name | Description | Type | Note |
| -- | -- | -- | -- |
| topic | Name of the DataCue message topic | string | _like_ `datacue-<namespace>`|
| subscription | Name of the DataCue message subscription | string | _like_ `datacue-<namespace>-dataflow`|
| dlq | Map to the name of the DLQ topic/sub | map | _like_ `{"topic" => "datacue-<namespace>-dql", "subscription" => "datacue-<namespace>-dql"}`|
