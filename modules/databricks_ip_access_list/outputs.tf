output "ip_access_list_id" {
  description = "The ID of the IP access list."
  value       = databricks_ip_access_list.this.id
}

output "ip_access_list" {
  description = "The full IP access list resource."
  value       = databricks_ip_access_list.this
}