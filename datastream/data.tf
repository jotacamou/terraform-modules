/* Data sources */

locals {
  # See: https://github.com/dave-inc/sre/blob/master/bin/setupdb-create-mysql-secrets.sh#L56
  # See: https://regex101.com/r/8GW8QC/1
  dbkey = length(regexall("^(.*?)-[0-9]", var.mysql_conn.instance)) > 0 ? regex("^(.*?)-[0-9]", var.mysql_conn.instance)[0] : var.mysql_conn.instance
}

data "google_sql_database_instance" "instance" {
  project = var.project
  name    = var.mysql_conn.instance
}

# GSM secrets:

data "google_secret_manager_secret_version" "mysql-datastream-password" {
  project = var.project
  secret  = "${local.dbkey}-mysql-datastream-password"
}

data "google_secret_manager_secret_version" "mysql-client-key" {
  project = var.project
  secret  = "${local.dbkey}-mysql-client-key"
  version = 1
}

data "google_secret_manager_secret_version" "mysql-client-cert" {
  project = var.project
  secret  = "${local.dbkey}-mysql-client-cert"
  version = 1
}

data "google_secret_manager_secret_version" "mysql-server-ca" {
  project = var.project
  secret  = "${local.dbkey}-mysql-server-ca"
  version = 1
}
