output "group_member_id" {
  description = "The unique identifier for the group membership"
  value       = databricks_group_member.this.id
}

output "group_id" {
  description = "The ID of the group"
  value       = databricks_group_member.this.group_id
}

output "member_id" {
  description = "The ID of the member"
  value       = databricks_group_member.this.member_id
}