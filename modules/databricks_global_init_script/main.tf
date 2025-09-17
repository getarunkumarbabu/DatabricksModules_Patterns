locals {
  script_content = var.source_path != null ? file(var.source_path) : var.content
}

resource "databricks_global_init_script" "this" {
  name     = var.name
  enabled  = var.enabled
  position = var.position

  # Use either source path or provided content
  dynamic "source" {
    for_each = var.source != null ? [var.source] : []
    content {
      path = source.value
    }
  }

  dynamic "content" {
    for_each = var.source == null ? [local.script_content] : []
    content {
      base64 = base64encode(content.value)
    }
  }
}