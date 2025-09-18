resource "databricks_recipient" "this" {
  name                = var.name
  authentication_type = var.authentication_type
  comment             = var.comment
  owner               = var.owner

  dynamic "ip_access_list" {
    for_each = var.allowed_ip_addresses != null ? [1] : []
    content {
      allowed_ip_addresses = var.allowed_ip_addresses
    }
  }

  sharing_code = var.sharing_code
}