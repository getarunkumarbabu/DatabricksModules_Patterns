resource "databricks_mlflow_webhook" "this" {
  description = var.description
  events      = var.events
  status      = var.status

  http_url_spec {
    url                    = var.url
    enable_ssl_verification = var.enable_ssl_verification
    authorization          = var.authorization
  }

  dynamic "job_spec" {
    for_each = var.job_spec != null ? [var.job_spec] : []
    content {
      job_id        = job_spec.value.job_id
      workspace_url = job_spec.value.workspace
      access_token  = job_spec.value.access_token
    }
  }
}