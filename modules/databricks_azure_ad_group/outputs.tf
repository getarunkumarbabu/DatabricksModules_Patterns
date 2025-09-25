# Outputs for Databricks Azure AD Group module

output "group_id" {
  description = "The ID of the Azure AD group in Databricks"
  value       = databricks_group.azure_ad_group.id
}

output "group_display_name" {
  description = "The display name of the Azure AD group"
  value       = databricks_group.azure_ad_group.display_name
}

output "group_external_id" {
  description = "The external ID of the Azure AD group (Azure AD Object ID)"
  value       = databricks_group.azure_ad_group.external_id
}

output "assigned_role" {
  description = "The role assigned to the group (admin or user)"
  value       = var.role
}

output "workspace_access_granted" {
  description = "Whether workspace access was granted to the group"
  value       = var.workspace_access
}

# Summary of all permissions
output "permission_summary" {
  description = "Summary of all permissions assigned to the group"
  value = {
    group = {
      id           = databricks_group.azure_ad_group.id
      display_name = databricks_group.azure_ad_group.display_name
      external_id  = databricks_group.azure_ad_group.external_id
    }
    role             = var.role
    workspace_access = var.workspace_access
  }
}