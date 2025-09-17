output "alert_id" {
  description = "The ID of the created SQL alert"
  value       = databricks_sql_alert.this.id
}

output "alert_name" {
  description = "The name of the SQL alert"
  value       = databricks_sql_alert.this.name
}

output "alert_state" {
  description = "The current state of the alert"
  value       = databricks_sql_alert.this.state
}