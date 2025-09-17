output "model_id" {
  description = "The ID of the registered MLflow model"
  value       = databricks_registered_model.this.id
}

output "model_name" {
  description = "The name of the MLflow model"
  value       = databricks_registered_model.this.name
}

output "catalog_name" {
  description = "The name of the catalog containing the model"
  value       = databricks_registered_model.this.catalog_name
}

output "schema_name" {
  description = "The name of the schema containing the model"
  value       = databricks_registered_model.this.schema_name
}

output "storage_location" {
  description = "The storage location of the model artifacts"
  value       = databricks_registered_model.this.storage_location
}