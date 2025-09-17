resource "databricks_ip_access_list" "this" {
  label        = var.label
  list_type    = var.list_type
  ip_addresses = var.ip_addresses
  enabled      = var.enabled
}