# Databricks IP Access List Module

This module manages IP access lists in Databricks, allowing you to control which IP addresses can access your Databricks workspace.

## Usage

```hcl
module "ip_access_list" {
  source = "./modules/databricks_ip_access_list"

  label        = "allowed_ips"
  list_type    = "ALLOW"
  ip_addresses = ["192.168.1.0/24", "10.0.0.0/16"]
  enabled      = true
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| label | A label to organize a list of IP access lists | `string` | n/a | yes |
| list_type | The type of IP access list. Valid values are: ALLOW, BLOCK | `string` | n/a | yes |
| ip_addresses | A list of IP addresses/CIDR ranges to be added to the IP access list | `list(string)` | n/a | yes |
| enabled | Whether this IP access list is enabled | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ip_access_list_id | The ID of the IP access list |
| ip_access_list | The full IP access list resource |