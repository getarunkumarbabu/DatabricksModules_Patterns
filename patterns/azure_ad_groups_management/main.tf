# Simple Azure AD Groups Management
# This configuration adds admin and user Azure AD groups to Databricks workspace

terraform {
  required_version = ">= 0.13"
  
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.90.0"
    }
  }
}

# Configure the Databricks Provider
provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

# Add Admin Groups
module "admin_groups" {
  source = "../../modules/databricks_azure_ad_group"
  
  for_each = var.admin_groups

  group_display_name = each.value.display_name
  group_external_id  = each.value.external_id
  role              = "admin"
  workspace_access  = true
}

# Add User Groups
module "user_groups" {
  source = "../../modules/databricks_azure_ad_group"
  
  for_each = var.user_groups

  group_display_name = each.value.display_name
  group_external_id  = each.value.external_id
  role              = "user"
  workspace_access  = true
}