# Datastream

A module to help with datastream set-up:

- Enforces naming conventions.
- Takes care of GSM references.

## Example Usage

Creates a connection profile for the credit builder Db and replicates table1, table2, and table3 -
the first two with automatic backfills and the last left for a manual one.

```hcl
module "credit-builder" {
  source  = "./../../../modules/datastream"
  project = var.graphql-services_project
  mysql_tables = [
    "table1",
    "table2",
    "table3",
  ]
  mysql_tables_exclude_backfill = ["table3"]
  mysql_conn = {
    instance = "credit-builder-1"
    database = "credit_builder"
  }
  gcs_connection_profile_id = google_datastream_connection_profile.dave-graphql-datastream.id
}
```

Creates a connection profile for the credit builder Db and replicates all current and future tables
w/ automatics backfills.

```hcl
module "credit-builder" {
  source  = "./../../../modules/datastream"
  project = var.graphql-services_project
  mysql_conn = {
    instance = "credit-builder-1"
    database = "credit_builder"
  }
  gcs_connection_profile_id = google_datastream_connection_profile.dave-graphql-datastream.id
}
```

## Requirements

| Name | Version |
| -- | -- |
| terraform | 1.4.0 |
| google    | >= 4.60.0 |

## Providers

| Name   | Version |
| -- | -- |
| google | >= 4.60.0 |

## Inputs

| Name | Description | Type | Default | Required |
| -- | -- | -- | -- | -- | 
| project | GCP project - must be one of "internal-1-4825", "shared-1098", "graphql-services-e5ba", "dave-173321"| string | | Yes |
| gcs_connection_profile_id | GCS connection profile Id | string | | Yes |
| mysql_db | MySQL connection variable | _Nested_<br/> `instance`: string, <br/>`database`: string, <br/> `user`: string |user = "datastream" | Yes |
| mysql_tables | List of MySQL tables to include in stream - if not provided will include all | list(string) | | No |
| mysql_tables_exclude_backfill | List of MySQL tables to **exclude** from automatic backfill - if not provided will not exclude **any** | list(string) | | No |
| stream_num | Stream number: zero padded two digit numeric string. | string | "01" | No |

## Outputs

| Name | Description | Type | Note |
| -- | -- | -- | -- |
| stream_id | Id of the stream | string | _like_ `projects/{{project}}/locations/{{location}}/streams/{{stream_id}}` |
| connection_profile_id | Id of the connection profile | string | _like_ `projects/{{project}}/locations/{{location}}/privateConnections/{{private_connection_id}}` |
