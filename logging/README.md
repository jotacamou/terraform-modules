# terraform/modules/logging

## Example Usage

```hcl
module "logging" {
  # Ensure this path is correct from the location you are referencing the module
  source   = "./../../../modules/logging"
  project   = local.project

  # If not defined, defaults to all items in the local.logged object being setup.  You must enable/disable PCI as well
  overrides = {
    export-container-logs-to-central-location = {
      enabled = false
      pci     = false
    }
  }
}
```

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | 1.4.6     |
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
| unique\_writer\_identity | Use a unique writer | `bool` | `false` | no |
| disabled | If set to true, then this sink is disabled and it does not export any log entries. | `bool` | `false` | no |

## Outputs
