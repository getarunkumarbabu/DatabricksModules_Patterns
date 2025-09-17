# Databricks Share Module

This module manages Delta Sharing shares in Databricks, allowing you to securely share data with external organizations.

## Usage

```hcl
module "delta_share" {
  source = "./modules/databricks_share"

  name    = "my-share"
  comment = "Share for partner organization"

  # Define data objects to share
  data_object_permissions = [
    {
      name            = "main.marketing.customer_data"
      data_object_type = "TABLE"
      privilege       = "SELECT"
    },
    {
      name            = "main.sales.transactions"
      data_object_type = "TABLE"
      privilege       = "SELECT"
    }
  ]

  # Configure recipients
  recipients = [
    {
      name = "partner-org"
      allowed_ip_addresses = ["10.0.0.0/24"]
      comment = "Partner organization access"
    },
    {
      name = "external-vendor"
      data_recipient_global_metastore_id = "12345678-90ab-cdef-1234-567890abcdef"
      sharing_code = "ABC123XYZ"
    }
  ]
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
| name | Name of the share | string | n/a | yes |
| comment | Comment describing the share | string | null | no |
| owner | Owner of the share | string | null | no |
| data_object_permissions | List of data object permissions | list(object) | null | no |
| recipients | List of share recipients | list(object) | null | no |

### Data Object Permissions Object

```hcl
object({
  data_object_type = string # Type of data object (e.g., TABLE, VIEW)
  name            = string  # Full name of object (catalog.schema.object)
  privilege       = string  # Permission level (e.g., SELECT)
})
```

### Recipients Object

```hcl
object({
  name           = string
  allowed_ip_addresses = optional(list(string))
  comment        = optional(string)
  data_recipient_global_metastore_id = optional(string)
  sharing_code   = optional(string)
})
```

## Outputs

| Name | Description |
|------|-------------|
| share_id | ID of the created share |
| share_name | Name of the share |
| owner | Owner of the share |

## Notes

- Only one authentication method should be used per recipient (IP-based or metastore ID)
- Consider security implications when configuring allowed IP addresses
- Ensure proper access controls on shared data objects
- Monitor share usage through Databricks audit logs