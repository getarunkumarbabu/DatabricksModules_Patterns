# =============================================================================
# Example Configuration for Databricks Role Assignments
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Groups Configuration
# -----------------------------------------------------------------------------
# List of admin groups with their configurations
admin_groups = [
  {
    display_name = "databricks-super-admins@yourdomain.com"
    additional_roles = ["super-admin"]  # Additional roles beyond admin
  },
  {
    display_name = "databricks-admins@yourdomain.com"
    additional_roles = []  # Just the default admin role
  },
  {
    display_name = "databricks-security-admins@yourdomain.com"
    additional_roles = ["security-admin"]
  }
]

# -----------------------------------------------------------------------------
# User Groups Configuration
# -----------------------------------------------------------------------------
# List of user groups with their specific role configurations
user_groups = [
  {
    display_name = "databricks-data-scientists@yourdomain.com"
    roles = ["user", "notebook-user"]
    workspace_access = true
  },
  {
    display_name = "databricks-data-engineers@yourdomain.com"
    roles = ["user", "job-user"]
    workspace_access = true
  },
  {
    display_name = "databricks-analysts@yourdomain.com"
    roles = ["user", "sql-user"]
    workspace_access = true
  },
  {
    display_name = "databricks-readonly@yourdomain.com"
    roles = ["user"]
    workspace_access = false  # Read-only users don't need workspace access
  }
]