# Azure Databricks IP Access List Module

This module manages IP access lists in Azure Databricks workspaces, enabling secure network access control and integration with Azure Virtual Networks (VNETs). It supports both IPv4 and IPv6 addresses and is designed to work seamlessly with Azure networking features.

## Features

- Azure VNET CIDR range support
- IPv4 and IPv6 validation
- Integration with Azure Network Security Groups
- Support for allow/block lists
- Temporary access management
- Azure resource naming conventions

## Azure Network Integration

This module helps secure Azure Databricks workspaces by:
1. Controlling access from Azure VNETs
2. Managing public IP access
3. Supporting Azure Private Link
4. Enabling secure VNET injection

## Usage Examples

### Allow Azure VNET Access
```hcl
module "vnet_access" {
  source = "../modules/databricks_ip_access_list"

  label        = "azure-vnet-prod"
  list_type    = "ALLOW"
  ip_addresses = ["10.0.0.0/16"]  # Azure VNET CIDR
  enabled      = true
}
```

### Block Specific Ranges
```hcl
module "blocked_ips" {
  source = "../modules/databricks_ip_access_list"

  label        = "blocked-ranges"
  list_type    = "BLOCK"
  ip_addresses = ["203.0.113.0/24", "198.51.100.0/24"]
  enabled      = true
}
```

### Development Access with IPv6
```hcl
module "dev_access" {
  source = "../modules/databricks_ip_access_list"

  label        = "dev-environment"
  list_type    = "ALLOW"
  ip_addresses = [
    "10.0.0.0/16",                                    # Azure VNET
    "2001:0db8:85a3:0000:0000:8a2e:0370:7334/64"    # IPv6 range
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |
| azurerm | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| label | Label for the IP access list. Use Azure naming conventions. | string | n/a | yes |
| list_type | Type of list (ALLOW/BLOCK). Use ALLOW for Azure VNET ranges. | string | n/a | yes |
| ip_addresses | List of IP/CIDR ranges. Include Azure VNET CIDR ranges. | list(string) | n/a | yes |
| enabled | Whether the IP access list is enabled | bool | true | no |

## Outputs

| Name | Description |
|------|-------------|
| ip_access_list_id | ID of the created IP access list |
| enabled_status | Current enabled status of the list |

## Azure Network Security Best Practices

1. **VNET Integration**
   - Use Azure VNET CIDR ranges
   - Plan IP range allocation
   - Consider future VNET peering
   - Document network topology

2. **Security Controls**
   - Implement least-privilege access
   - Use Network Security Groups
   - Enable Azure DDoS protection
   - Regular security audits

3. **Access Management**
   - Document all allowed ranges
   - Regular access reviews
   - Implement change control
   - Monitor access patterns

4. **Compliance**
   - Follow Azure security baselines
   - Maintain access logs
   - Regular compliance checks
   - Document exceptions

## Network Planning

### Azure VNET Considerations
1. **CIDR Range Selection**
   - Plan for growth
   - Consider peering needs
   - Avoid overlapping ranges
   - Document allocations

2. **Subnet Planning**
   - Separate public/private subnets
   - Plan for service endpoints
   - Consider Azure Private Link
   - Reserve ranges for expansion

3. **Security Zones**
   - Define security boundaries
   - Plan for DMZs
   - Implement network isolation
   - Document security zones

### Implementation Steps

1. **Initial Setup**
   - Create Azure VNET
   - Configure subnets
   - Set up NSGs
   - Enable monitoring

2. **Access List Configuration**
   - Define allowed ranges
   - Configure block lists
   - Test access
   - Document configuration

3. **Monitoring Setup**
   - Enable Azure Monitor
   - Configure alerts
   - Set up logging
   - Regular reviews

## Notes

- Always use precise CIDR ranges
- Regular access list audits recommended
- Monitor for suspicious patterns
- Keep documentation updated
- Plan for disaster recovery
- Test failover scenarios
- Monitor network latency