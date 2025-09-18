output "external_location_id" {
  description = "The ID of the external location in Unity Catalog"
  value       = databricks_external_location.this.id
}

output "external_location_name" {
  description = "The name of the external location"
  value       = databricks_external_location.this.name
}

output "storage_location" {
  description = "Azure storage location details extracted from URL"
  value = {
    container_name  = regex("^abfss://([^@]+)@", var.url)[0]
    storage_account = regex("@([^\\.]+)\\.dfs\\.core\\.windows\\.net", var.url)[0]
    path            = regex("\\.windows\\.net(/.*)?$", var.url)[0]
    credential      = var.credential_name
    access_mode     = var.read_only == true ? "READ_ONLY" : "READ_WRITE"
  }
}

output "external_location_config" {
  description = "Complete external location configuration"
  value = {
    id         = databricks_external_location.this.id
    name       = databricks_external_location.this.name
    url        = databricks_external_location.this.url
    credential = databricks_external_location.this.credential_name
    owner      = databricks_external_location.this.owner
    comment    = databricks_external_location.this.comment
    read_only  = var.read_only
  }
}

output "access_url" {
  description = "DBFS access URL for the external location"
  value       = format("dbfs://%s/%s", databricks_external_location.this.name, trim(regex("\\.windows\\.net(/.*)?$", var.url)[0], "/"))
}