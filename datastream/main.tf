/**
 * Datastream module main
 */

terraform {
  required_version = "1.4.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.60.0"
    }
  }

}

locals {
  # Used in nested dynamic block
  exlude_db = length(var.mysql_tables_exclude_backfill) > 1 ? [var.mysql_conn.database] : [""]
}

# Connection profile:

resource "google_datastream_connection_profile" "cloudsql" {
  project               = var.project
  location              = "us-central1"
  display_name          = "cloudsql-${var.mysql_conn.instance}"
  connection_profile_id = "cloudsql-${var.mysql_conn.instance}"

  mysql_profile {
    hostname = data.google_sql_database_instance.instance.public_ip_address
    port     = 3306

    # Managed secrets - MySql user auth:
    username = var.mysql_conn.user
    password = data.google_secret_manager_secret_version.mysql-datastream-password.secret_data

    # Managed secrets - ssl, the data source returns an extra trailing newline:
    ssl_config {
      client_key         = trimsuffix(data.google_secret_manager_secret_version.mysql-client-key.secret_data, "\n")
      client_certificate = trimsuffix(data.google_secret_manager_secret_version.mysql-client-cert.secret_data, "\n")
      ca_certificate     = trimsuffix(data.google_secret_manager_secret_version.mysql-server-ca.secret_data, "\n")
    }

  }
}

# Stream:

resource "google_datastream_stream" "stream" {
  project       = var.project
  location      = "us-central1"
  display_name  = "${var.mysql_conn.database}-stream${var.stream_num}"
  stream_id     = "${var.mysql_conn.database}-stream${var.stream_num}"
  desired_state = "RUNNING"

  # Destination GCS configuration:
  destination_config {
    destination_connection_profile = var.gcs_connection_profile_id
    gcs_destination_config {
      path = "${var.mysql_conn.database}-stream${var.stream_num}/"

      # Whichever condition is met first, `file_rotation_interval` must be 15-60
      file_rotation_interval = "60s"
      file_rotation_mb       = 50

      # GZIP/Json, can parametrize Avro in the future
      json_file_format {
        schema_file_format = "NO_SCHEMA_FILE"
        compression        = "GZIP"
      }
    }
  }

  # Source MySql configuration
  source_config {
    source_connection_profile = google_datastream_connection_profile.cloudsql.id
    mysql_source_config {
      include_objects {
        mysql_databases {
          database = var.mysql_conn.database

          # Includes each table in `mysql_tables` IF not empty, else includes all tables in the Db
          dynamic "mysql_tables" {
            for_each = toset(var.mysql_tables)
            content {
              table = mysql_tables.value
            }
          }

        }
      }
    }
  }

  # Exclude big tables from backfill, backfills can still be triggered in the UI
  backfill_all {
    mysql_excluded_objects {

      # Excludes each table in IF `mysql_tables_exclude_backfill` is not empty
      dynamic "mysql_databases" {
        for_each = toset(local.exlude_db)
        content {
          database = mysql_databases.value
          dynamic "mysql_tables" {
            for_each = toset(var.mysql_tables_exclude_backfill)
            content {
              table = mysql_tables.value
            }
          }
        }
      }

    }
  }

}
