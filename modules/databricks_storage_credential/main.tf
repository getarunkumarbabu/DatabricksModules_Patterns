resource "databricks_storage_credential" "this" {
  name    = var.name
  comment = var.comment
  owner   = var.owner

  dynamic "azure_managed_identity" {
    for_each = var.azure_managed_identity != null ? [var.azure_managed_identity] : []
    content {
      access_connector_id = azure_managed_identity.value.access_connector_id
    }
  }

  dynamic "azure_service_principal" {
    for_each = var.azure_service_principal != null ? [var.azure_service_principal] : []
    content {
      directory_id   = azure_service_principal.value.directory_id
      application_id = azure_service_principal.value.application_id
      client_secret  = azure_service_principal.value.client_secret
    }
  }

  force_destroy = var.force_destroy
  force_update  = var.force_update
}