# Databricks Azure AD Group Module
# This module adds existing Azure AD groups to Databricks workspace and assigns permissions

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.0.0"
    }
  }
}

# Create or add the Azure AD group to the workspace
# This will add account-level groups to the workspace
resource "databricks_group" "azure_ad_group" {
  display_name               = var.group_display_name
  external_id               = var.group_external_id
  allow_cluster_create      = var.role == "admin" ? true : false
  allow_instance_pool_create = var.role == "admin" ? true : false
  workspace_access          = var.workspace_access
  
  # If the group already exists at account level, this will add it to workspace
  # If it doesn't exist, this will create it with the external_id for Azure AD sync
}