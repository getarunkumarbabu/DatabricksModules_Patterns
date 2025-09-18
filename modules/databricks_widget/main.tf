resource "databricks_widget" "this" {
  name             = var.name
  visualization_id = var.visualization_id
  position         = var.position
  description      = var.description

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      title        = parameter.value.title
      text_value   = try(parameter.value.text_value, null)
      date_value   = try(parameter.value.date_value, null)
      number_value = try(parameter.value.number_value, null)
    }
  }
}