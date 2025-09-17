variable "notebook_id" {
  description = "The ID of the notebook to add the widget to"
  type        = string
}

variable "position" {
  description = "The position of the widget in the notebook"
  type        = number
}

variable "text_widget" {
  description = "Configuration for a text widget"
  type = object({
    value = string
  })
  default = null
}

variable "combobox_widget" {
  description = "Configuration for a combobox widget"
  type = object({
    label         = string
    default_value = string
    options       = list(string)
  })
  default = null
}

variable "multiselect_widget" {
  description = "Configuration for a multiselect widget"
  type = object({
    label         = string
    default_value = list(string)
    options       = list(string)
  })
  default = null
}

variable "validate_widget_types" {
  type = string
  description = "Internal validation to ensure only one widget type is specified"
  default = null
  validation {
    condition = (
      var.text_widget != null && var.combobox_widget == null && var.multiselect_widget == null ||
      var.text_widget == null && var.combobox_widget != null && var.multiselect_widget == null ||
      var.text_widget == null && var.combobox_widget == null && var.multiselect_widget != null ||
      var.text_widget == null && var.combobox_widget == null && var.multiselect_widget == null
    )
    error_message = "Only one widget type can be specified at a time."
  }
}