output "mount_id" {
  description = "The unique identifier of the mount"
  value       = databricks_mount.this.id
}

output "mount_name" {
  description = "The name of the mount point"
  value       = databricks_mount.this.name
}

output "mount_url" {
  description = "The DBFS URL for accessing the mount point"
  value       = databricks_mount.this.url
}

output "source_url" {
  description = "The Azure Storage source URL (ABFS endpoint)"
  value       = var.uri
  sensitive   = false
}

output "auth_type" {
  description = "The authentication type used for the mount"
  value       = var.auth_type
}

output "azure_config" {
  description = "Azure storage configuration details (excluding secrets)"
  value = {
    container_name       = var.container_name
    storage_account_name = var.storage_account_name
    directory           = var.directory
    auth_type           = var.auth_type
    auth_method         = var.auth_type == "SERVICE_PRINCIPAL" ? "Service Principal" : "Managed Identity"
  }
}

output "mount_source" {
  description = "Full details about the mount source location"
  value = {
    storage_account = var.storage_account_name
    container      = var.container_name
    directory      = var.directory != "" ? var.directory : "/"
    endpoint_type  = "ABFS"
    region        = regex(".*\\.([a-z]+)[0-9]+\\..*", var.uri)[0]
  }
}