output "mount_id" {
  description = "The ID of the mount"
  value       = databricks_mount.this.id
}

output "mount_url" {
  description = "The DBFS URL for the mount point"
  value       = databricks_mount.this.url
}

output "mount" {
  description = "The full mount resource"
  value       = databricks_mount.this
}