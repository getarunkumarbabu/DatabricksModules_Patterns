output "cluster_id" {
  description = "ID of the cluster the rules are applied to"
  value       = var.cluster_id
}

output "access_control_rules" {
  description = "List of applied access control rules"
  value = [
    for rule in databricks_permissions.cluster_access.access_control :
    {
      principal        = rule.principal
      permission_level = rule.permission_level
    }
  ]
}