provider "databricks" {
  host                        = var.host
  token                       = var.token
  azure_workspace_resource_id = var.azure_workspace_resource_id
  azure_client_id             = var.azure_client_id
  azure_client_secret         = var.azure_client_secret
  azure_tenant_id             = var.azure_tenant_id
}