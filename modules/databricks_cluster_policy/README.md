# Databricks Cluster Policy Module

This module manages cluster policies using the `databricks_cluster_policy` resource.

## Inputs

- `name` (string) - Name of the cluster policy
- `definition` (any) - Policy definition as JSON string or map
- `policy_family_id` (string, optional) - Policy family ID to extend
- `policy_family_overrides` (map, optional) - Overrides when using a policy family

## Outputs

- `policy_id` - ID of the created policy
- `policy_name` - Name of the created policy

## Example

```hcl
module "dev_policy" {
  source = "../modules/databricks_cluster_policy"
  
  name = "development-policy"
  definition = jsonencode({
    "dbus_per_hour": {
      "type": "range",
      "maxValue": 10
    },
    "autotermination_minutes": {
      "type": "fixed",
      "value": 120
    }
  })
}
```

## Policy Definition Notes

Common policy controls:
- Node type restrictions
- Spark version restrictions
- Auto-termination settings
- DBU limits
- Instance pool requirements
- Cluster size limits
- Tag requirements