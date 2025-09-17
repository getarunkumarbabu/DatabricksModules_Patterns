variable "model_name" {
  description = "Name of the MLflow model"
  type        = string
}

variable "description" {
  description = "Description of the MLflow model"
  type        = string
  default     = null
}

variable "catalog_name" {
  description = "Name of the Unity Catalog where the model will be registered"
  type        = string
}

variable "schema_name" {
  description = "Name of the schema where the model will be registered"
  type        = string
}

variable "storage_location" {
  description = "Storage location for the model artifacts"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be applied to the model"
  type        = map(string)
  default     = null
}

variable "permissions" {
  description = "Permissions configuration for the model"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = null
}