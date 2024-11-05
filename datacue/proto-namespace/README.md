# DataCue: Protobuf Namespace

*For [datacue/snow-burst](https://github.com/dave-inc/laser-beam/tree/main/beam/snowburst) pipes*.

Module creates:

1. An un-typed topic for app teams to write a family of protobuf encoded messages to.
2. A subscription for a Dataflow consumer to read from.

Naming conventions and IAM permissions are built into the module.

It's assumed that multiple messages types will be sent to the topic created here.

## Environment Breakdown

Topics are created in the *Producer project* (where the API lives).

Subscriptions are created in the *Consumer project* (where DE pipes runs).

| Env | Producer project | Consumer project |
| -- | -- | -- |
| staging | internal-1-4825 | internal-1-4825 |
| production | shared-1098, dave-173321, datasci-10a8, graphql-services-e5ba | datasci-10a8 |

## Example Usage

```hcl
module "datacue-messages-test" {
  source    = "./../../../modules/datacue/proto-namespace"
  project   = var.internal_project
  namespace = "balance"
}
```

## Requirements

| Name | Version |
| -- | -- |
| terraform | >= 1.2.1 |
| google    | >= 4.4.1 |

## Providers

| Name   | Version |
|--------|---------|
| google | >= 4.4.1 |

## Inputs

| Name | Description | Type | Default | Required |
| -- | -- | -- | -- | -- |
| project | GCP project | string | | Yes |
| name| Pub/Sub DataCue message name | string | | Yes |
| publishers | Namespace for messages | list(string) | [] | no |


## Outputs

| Name | Description | Type | Note |
| -- | -- | -- | -- |
| topic | Name of the DataCue message topic | string | *like* `datacue-<namespace>`|
| subscription | Name of the DataCue message subscription | string | *like* `datacue-snowburst-<namespace>-dataflow`|
