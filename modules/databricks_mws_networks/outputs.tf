output "network_id" {
  description = "ID of the created network configuration"
  value       = databricks_mws_networks.this.network_id
}

output "creation_time" {
  description = "Time when the network configuration was created"
  value       = databricks_mws_networks.this.creation_time
}

output "network_name" {
  description = "Name of the network configuration"
  value       = databricks_mws_networks.this.network_name
}