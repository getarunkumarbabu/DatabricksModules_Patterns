# =============================================================================
# Example Configuration for Databricks Role Assignments
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Group Configuration
# -----------------------------------------------------------------------------
# Name of the existing Azure AD group to be assigned admin role
# This group must already exist in Azure AD and be synchronized with Databricks
existing_admin_group_name = "databricks-admins@yourdomain.com"

# -----------------------------------------------------------------------------
# User Groups Configuration
# -----------------------------------------------------------------------------
# List of existing Azure AD groups to be assigned user role and SQL access
# These groups must already exist in Azure AD and be synchronized with Databricks
existing_user_group_names = [
  "databricks-data-scientists@yourdomain.com",
  "databricks-data-engineers@yourdomain.com",
  "databricks-analysts@yourdomain.com"
]