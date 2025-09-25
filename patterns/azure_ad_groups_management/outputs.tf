# Outputs for Simple Azure AD Groups Management

# Admin groups summary
output "admin_groups" {
  description = "Summary of admin groups"
  value = {
    for group_name, group_config in module.admin_groups :
    group_name => {
      group_id        = group_config.group_id
      display_name    = group_config.group_display_name
      external_id     = group_config.group_external_id
      role           = group_config.assigned_role
      workspace_access = group_config.workspace_access_granted
    }
  }
}

# User groups summary
output "user_groups" {
  description = "Summary of user groups"
  value = {
    for group_name, group_config in module.user_groups :
    group_name => {
      group_id        = group_config.group_id
      display_name    = group_config.group_display_name
      external_id     = group_config.group_external_id
      role           = group_config.assigned_role
      workspace_access = group_config.workspace_access_granted
    }
  }
}

# Simple statistics
output "group_statistics" {
  description = "Simple statistics about configured groups"
  value = {
    total_admin_groups = length(var.admin_groups)
    total_user_groups  = length(var.user_groups)
    admin_group_names  = var.admin_groups
    user_group_names   = var.user_groups
  }
}

# Note: Diagnostic outputs removed - databricks_groups data source doesn't exist
# To identify available groups, check your Databricks workspace Groups section manually