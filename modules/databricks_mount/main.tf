locals {
  # Generate mount-specific configuration based on auth type
  mount_config = var.auth_type == "SERVICE_PRINCIPAL" ? {
    "fs.azure.account.auth.type"                          = "OAuth"
    "fs.azure.account.oauth.provider.type"                = "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
    "fs.azure.account.oauth2.client.endpoint"             = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/token"
    "fs.azure.account.oauth2.client.id"                   = var.client_id
    "fs.azure.account.oauth2.client.secret"               = var.client_secret
    "fs.azure.createRemoteFileSystemDuringInitialization" = "false"
    } : {
    "fs.azure.account.auth.type"                          = "CustomManaged"
    "fs.azure.createRemoteFileSystemDuringInitialization" = "false"
  }
}

resource "databricks_mount" "this" {
  name = var.name
  uri  = var.uri

  extra_configs = merge(local.mount_config, var.extra_config)

  lifecycle {
    precondition {
      condition     = var.auth_type == "SERVICE_PRINCIPAL" ? (var.tenant_id != null && var.client_id != null && var.client_secret != null) : true
      error_message = "When using SERVICE_PRINCIPAL auth_type, tenant_id, client_id, and client_secret must be provided."
    }
  }
}