resource "databricks_mws_customer_managed_keys" "this" {
  account_id = var.account_id
  use_cases  = var.use_cases
}