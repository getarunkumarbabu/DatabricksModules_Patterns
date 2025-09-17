# Databricks Connection Module

This module manages SQL warehouse connections in Databricks, allowing you to connect to various external data sources.

## Usage

```hcl
# Example MySQL connection
module "mysql_connection" {
  source = "./modules/databricks_connection"

  name            = "mysql-prod"
  connection_type = "MYSQL"
  comment         = "Production MySQL database connection"
  
  options = {
    host     = "mysql.example.com"
    port     = 3306
    database = "mydb"
    user     = "dbuser"
    password = var.mysql_password
    encrypt  = true
  }
}

# Example Snowflake connection
module "snowflake_connection" {
  source = "./modules/databricks_connection"

  name            = "snowflake-dw"
  connection_type = "SNOWFLAKE"
  comment         = "Data warehouse connection"
  
  options = {
    host      = "org.snowflakecomputing.com"
    database  = "ANALYTICS"
    warehouse = "COMPUTE_WH"
    role      = "ANALYST_ROLE"
    user      = "snowflake_user"
    password  = var.snowflake_password
  }
  
  properties = {
    "application" = "analytics"
    "environment" = "production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the connection | string | n/a | yes |
| connection_type | Type of connection | string | n/a | yes |
| comment | Comment describing the connection | string | null | no |
| owner | Owner of the connection | string | null | no |
| properties | Additional properties | map(string) | null | no |
| options | Connection options | object | null | no |

### Connection Options Object

```hcl
object({
  host                     = optional(string)
  port                     = optional(number)
  database                 = optional(string)
  user                     = optional(string)
  password                 = optional(string)
  encrypt                  = optional(bool)
  trust_server_certificate = optional(bool)
  authentication           = optional(string)
  role                     = optional(string)
  warehouse               = optional(string)
})
```

## Outputs

| Name | Description |
|------|-------------|
| connection_id | ID of the created connection |
| connection_name | Name of the connection |
| owner | Owner of the connection |
| metastore_id | Metastore ID for the connection |

## Notes

- Different connection types require different options
- Store sensitive credentials securely
- Use encryption when possible
- Consider access control requirements
- Test connections before deployment
- Monitor connection usage and performance