# Databricks Vector Search Index Module

This module manages vector search indexes in Databricks.

## Example Usage

```hcl
module "vector_search_index" {
  source = "./modules/databricks_vector_search_index"

  name           = "my-vector-index"
  catalog        = "main"
  schema         = "default"
  table_name     = "embeddings"
  primary_key    = "id"
  embedding_size = 768

  field_mappings = {
    field_name = "embedding"
    source     = "vector_column"
  }

  endpoint_name = "my-endpoint"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [databricks_vector_search_index.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/vector_search_index) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the vector search index | string | n/a | yes |
| catalog | Name of the catalog containing the source table | string | n/a | yes |
| schema | Name of the schema containing the source table | string | n/a | yes |
| table_name | Name of the source table | string | n/a | yes |
| primary_key | Primary key column in the source table | string | n/a | yes |
| embedding_size | Size of the embedding vectors | number | n/a | yes |
| field_mappings | Field mappings for the vector search index | object | n/a | yes |
| endpoint_name | Name of the endpoint to use for vector search | string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| index_id | ID of the vector search index |
| index_status | Status of the vector search index |

## Notes

- The source table must contain embedding vectors of the specified size
- The primary key column must contain unique values