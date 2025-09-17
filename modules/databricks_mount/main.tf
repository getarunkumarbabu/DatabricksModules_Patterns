resource "databricks_mount" "this" {
  name = var.name
  uri  = var.uri

  dynamic "s3" {
    for_each = var.s3_config != null ? [var.s3_config] : []
    content {
      bucket_name    = s3.value.bucket_name
      instance_profile = s3.value.instance_profile
      role_arn       = s3.value.role_arn
    }
  }

  dynamic "azure" {
    for_each = var.azure_config != null ? [var.azure_config] : []
    content {
      container_name  = azure.value.container_name
      storage_account_name = azure.value.storage_account_name
      directory       = azure.value.directory
      auth_type      = azure.value.auth_type
      tenant_id      = azure.value.tenant_id
      client_id      = azure.value.client_id
      client_secret  = azure.value.client_secret
    }
  }

  dynamic "gcp" {
    for_each = var.gcp_config != null ? [var.gcp_config] : []
    content {
      bucket_name     = gcp.value.bucket_name
      service_account = gcp.value.service_account
    }
  }

  extra_config = var.extra_config
}