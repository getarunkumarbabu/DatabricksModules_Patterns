output "user_id" {
  description = "ID of the created user"
  value       = databricks_user.this.id
}

output "user_name" {
  description = "User name of the created user"
  value       = databricks_user.this.user_name
}

output "home" {
  description = "Home directory of the user"
  value       = databricks_user.this.home
}