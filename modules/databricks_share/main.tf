resource "databricks_share" "this" {
  name    = var.name
  comment = var.comment
  owner   = var.owner

  dynamic "object" {
    for_each = var.data_object_permissions != null ? var.data_object_permissions : []
    content {
      name            = object.value.name
      data_object_type = object.value.data_object_type
      privilege       = object.value.privilege
    }
  }

  dynamic "recipient" {
    for_each = var.recipients != null ? var.recipients : []
    content {
      name           = recipient.value.name
      allowed_ip_addresses = recipient.value.allowed_ip_addresses
      comment        = lookup(recipient.value, "comment", null)
      data_recipient_global_metastore_id = lookup(recipient.value, "data_recipient_global_metastore_id", null)
      sharing_code   = lookup(recipient.value, "sharing_code", null)
    }
  }
}