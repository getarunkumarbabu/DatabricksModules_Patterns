# Databricks Vector Search Index Module

This module manages Vector Search Indexes in Databricks for similarity search and retrieval.

## Usage

```hcl
module "example_vector_search" {
  source = "./modules/databricks_vector_search_index"

  index_name    = "document_embeddings"
  endpoint_name = "vs_endpoint"
  primary_key   = "doc_id"
  index_type    = "APPROXIMATE_NEAREST_NEIGHBOR"

  source = {
    table = "main.documents"
    filter = "status = 'active'"
  }

  schema = {
    doc_id = {
      type       = "string"
      is_primary = true
    }
    embedding = {
      type      = "vector"
      dimension = 768
    }
    content = {
      type       = "string"
      is_nullable = true
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| index_name | Name of the vector search index | `string` | n/a | yes |
| endpoint_name | Name of the endpoint for the vector search index | `string` | n/a | yes |
| primary_key | Primary key column name for the index | `string` | n/a | yes |
| index_type | Type of the vector search index | `string` | `"APPROXIMATE_NEAREST_NEIGHBOR"` | no |
| source | Source configuration for the vector search index | `object` | `null` | no |
| schema | Schema definition for the vector search index | `map(object)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| index_id | The ID of the created vector search index |
| index_name | The name of the vector search index |
| endpoint_name | The name of the endpoint for the vector search index |
| status | The current status of the vector search index |