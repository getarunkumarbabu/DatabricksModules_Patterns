# Databricks Recipient Module

This module manages Delta Sharing recipients in Databricks, allowing you to configure who can access shared data.

## Usage

```hcl
# Example with IP-based authentication
module "ip_recipient" {
  source = "./modules/databricks_recipient"

  name               = "partner-org"
  authentication_type = "IP"
  comment            = "Partner organization access via IP whitelist"
  
  allowed_ip_addresses = [
    "10.0.0.0/24",
    "192.168.1.100"
  ]
}

# Example with token-based authentication
module "token_recipient" {
  source = "./modules/databricks_recipient"

  name               = "external-vendor"
  authentication_type = "TOKEN"
  comment            = "External vendor access via token"
  
  sharing_code       = "ABC123XYZ"
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
| name | Name of the recipient | string | n/a | yes |
| authentication_type | Authentication type (TOKEN or IP) | string | n/a | yes |
| comment | Comment describing the recipient | string | null | no |
| owner | Owner of the recipient | string | null | no |
| allowed_ip_addresses | List of IP addresses/CIDR blocks | list(string) | null | no |
| sharing_code | Sharing code for token auth | string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| recipient_id | ID of the created recipient |
| recipient_name | Name of the recipient |
| owner | Owner of the recipient |
| activation_url | Activation URL for token auth |

## Notes

- Choose either IP-based or token-based authentication
- For IP-based auth, specify allowed_ip_addresses
- For token-based auth, provide a sharing_code
- Activation URL is generated for token-based recipients
- Consider security implications when configuring access
- Monitor recipient access through audit logs