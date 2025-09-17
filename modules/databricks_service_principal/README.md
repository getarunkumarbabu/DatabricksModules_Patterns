# Azure Databricks Service Principal Module

This module manages service principals in Azure Databricks with enhanced Azure Active Directory (Azure AD) integration. It supports both standalone Databricks service principals and synchronized Azure AD service principals.

## Features

- Azure AD service principal synchronization
- Automatic Azure AD application ID mapping
- Granular permission management
- Built-in validation for Azure identifiers
- Integration with Azure RBAC

## Usage Examples

### Standalone Databricks Service Principal
```hcl
module "databricks_sp" {
  source = "../modules/databricks_service_principal"

  display_name             = "data-pipeline-sp"
  allow_cluster_create     = true
  allow_instance_pool_create = false
}
```

### Azure AD-Synchronized Service Principal
```hcl
module "aad_databricks_sp" {
  source = "../modules/databricks_service_principal"

  display_name    = "azure-ad-sp"
  application_id  = "12345678-1234-5678-abcd-1234567890ab"  # Azure AD App ID
  aad_object_id   = "87654321-4321-8765-dcba-0987654321fe"  # Azure AD Object ID
}
```

### Service Principal with Extended Permissions
```hcl
module "admin_sp" {
  source = "../modules/databricks_service_principal"

  display_name               = "admin-sp"
  application_id            = "12345678-1234-5678-abcd-1234567890ab"
  allow_cluster_create      = true
  allow_instance_pool_create = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | Display name of the service principal in Azure Databricks | string | n/a | yes |
| application_id | Application (client) ID from Azure AD for the service principal | string | null | no |
| aad_object_id | Azure AD Object ID of the service principal for synchronization | string | null | no |
| allow_cluster_create | Allow service principal to create Azure Databricks clusters | bool | false | no |
| allow_instance_pool_create | Allow service principal to create Azure Databricks instance pools | bool | false | no |
| force | Force creation even if service principal exists in Azure Databricks | bool | false | no |
| active | Whether the service principal is active in Azure Databricks | bool | true | no |

## Outputs

| Name | Description |
|------|-------------|
| service_principal_id | ID of the created service principal |
| application_id | Azure AD application ID (if provided) |
| aad_object_id | Azure AD object ID (if provided) |

## Azure Integration

### Azure AD Synchronization
This module supports synchronization with Azure AD service principals by providing:
1. Application ID mapping
2. Object ID synchronization
3. Automatic identity federation
4. Azure RBAC integration

### Prerequisites
1. Azure Databricks Premium tier
2. Azure AD Global Administrator or Privileged Role Administrator permissions
3. Properly configured Azure AD application
4. SCIM provisioning setup (recommended)

## Security Recommendations

1. **Identity Management**
   - Use Azure AD synchronized service principals
   - Enable SCIM provisioning
   - Regular access reviews
   - Implement proper lifecycle management

2. **Permission Control**
   - Follow least privilege principle
   - Use Azure RBAC when possible
   - Regular permission audits
   - Document access grants

3. **Monitoring**
   - Enable Azure AD audit logs
   - Monitor service principal activity
   - Set up alerts for changes
   - Regular usage review

4. **Compliance**
   - Follow Azure security baselines
   - Document compliance requirements
   - Regular compliance audits
   - Maintain access logs

## Best Practices

1. **Service Principal Creation**
   - Use meaningful display names
   - Document purpose and owner
   - Set appropriate permissions
   - Enable monitoring

2. **Azure AD Integration**
   - Always provide Application ID
   - Set up SCIM provisioning
   - Configure proper federation
   - Regular synchronization checks

3. **Permission Management**
   - Start with minimal permissions
   - Document permission changes
   - Regular access reviews
   - Use Azure RBAC groups

4. **Lifecycle Management**
   - Plan for deprovisioning
   - Regular activity monitoring
   - Automatic deactivation rules
   - Clean up unused principals

## Notes

- Azure AD synchronization requires Premium tier
- Service principals are workspace-specific
- Consider SCIM provisioning for automated management
- Regular audits recommended
- Document all service principal purposes
- Monitor usage patterns
- Plan for rotation and updates