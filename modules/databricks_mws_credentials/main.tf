resource "databricks_mws_credentials" "this" {
  credentials_name = var.credentials_name
  role_arn         = "credentials_admin"
}