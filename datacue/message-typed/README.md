# DataCue Typed Message

Module to create a typed topic and a subscription for app teams to write to and Dataflow to
read from.

## Example Usage

```hcl
module "datacue-message-test-basic1" {
  source  = "./../../../modules/datacue/message-typed"
  project = var.internal_project
  name    = "test.basic1"
  schema = {
    type = "AVRO"  # Schema must be one of AVRO/PROTOBUFF
    definition = jsonencode({ # This can done with a Json string or by using jsonencode
      type = "record"
      name = "basic1"
      fields = [
        {
          name = "string_col"
          type = "string"
        },
        {
          name = "int_col",
          type = "int"
        },
      ]
    })
  }
  publishers = [  # Users/SA's with publish privileges on the topic
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
| schema | Pub/Sub schema: schema type and schema definition | _Nested_<br/> `type`: string, <br/>`definition`: string | | Yes |
| publishers | Namespace for messages | list(string) | | Yes |


## Outputs

| Name | Description | Type | Note |
| -- | -- | -- | -- |
| topic | Name of the DataCue message topic | string | _like_ `datacue-<namespace>-<local>`|
| subscription | Name of the DataCue message subscription | string | _like_ `datacue-<namespace>-<local>`|