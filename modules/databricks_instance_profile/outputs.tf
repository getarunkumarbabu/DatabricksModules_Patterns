output "instance_profile_id" {
  description = "The unique identifier for the registered instance profile"
  value       = databricks_instance_profile.this.id
}

output "instance_profile_arn" {
  description = "The ARN of the registered instance profile"
  value       = databricks_instance_profile.this.instance_profile_arn
}

output "is_meta_instance_profile" {
  description = "Whether this is a meta instance profile"
  value       = databricks_instance_profile.this.is_meta_instance_profile
}