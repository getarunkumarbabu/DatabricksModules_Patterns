resource "databricks_connection" "this" {
  name            = var.name
  connection_type = var.connection_type
  comment         = var.comment
  owner           = var.owner
  properties      = var.properties

  dynamic "options" {
    for_each = var.options != null ? [var.options] : []
    content {
      host                  = lookup(options.value, "host", null)
      port                  = lookup(options.value, "port", null)
      database             = lookup(options.value, "database", null)
      user                 = lookup(options.value, "user", null)
      password             = lookup(options.value, "password", null)
      encrypt              = lookup(options.value, "encrypt", null)
      trust_server_certificate = lookup(options.value, "trust_server_certificate", null)
      authentication       = lookup(options.value, "authentication", null)
      role                 = lookup(options.value, "role", null)
      warehouse           = lookup(options.value, "warehouse", null)
    }
  }
}