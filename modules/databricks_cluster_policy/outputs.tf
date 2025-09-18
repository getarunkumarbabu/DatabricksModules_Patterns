output "policy_id" {
  description = "Unique identifier of the created cluster policy. Use this ID when referencing the policy in cluster configurations."
  value       = databricks_cluster_policy.this.id
}

output "policy_name" {
  description = "Display name of the cluster policy as shown in the Databricks workspace."
  value       = databricks_cluster_policy.this.name
}

output "policy_definition" {
  description = <<-EOT
    Complete policy definition with all restrictions and configurations.
    Includes any base policy family settings and applied overrides.
    Use this to verify the final effective policy settings.
  EOT
  value       = databricks_cluster_policy.this.definition
}

output "policy_family" {
  description = <<-EOT
    Details about the base policy family and applied overrides.
    Helps track policy inheritance and customizations.
    Will be null if no policy family was used.
  EOT
  value = var.policy_family_id != null ? {
    id           = var.policy_family_id
    overrides    = var.policy_family_overrides
    original_def = try(data.databricks_cluster_policy.family[0].definition, null)
  } : null
}

output "max_clusters_per_user" {
  description = "Maximum number of concurrent clusters a user can create with this policy. Null means unlimited."
  value       = databricks_cluster_policy.this.max_clusters_per_user
}

output "libraries" {
  description = <<-EOT
    Standard library configuration applied to all clusters using this policy.
    Includes all package types:
    - jar: JVM libraries
    - egg: Python eggs
    - whl: Python wheels
    - pypi: PyPI packages
    - maven: Maven artifacts
    - cran: R packages
  EOT
  value       = var.libraries
}

output "policy_summary" {
  description = "High-level summary of key policy settings and restrictions."
  value = {
    name              = databricks_cluster_policy.this.name
    id                = databricks_cluster_policy.this.id
    description       = databricks_cluster_policy.this.description
    uses_family       = var.policy_family_id != null
    family_id         = var.policy_family_id
    max_clusters      = databricks_cluster_policy.this.max_clusters_per_user
    has_libraries     = var.libraries != null
    creation_time     = databricks_cluster_policy.this.created_at
    last_updated_time = databricks_cluster_policy.this.updated_at
  }
}

output "applied_restrictions" {
  description = <<-EOT
    Analysis of the policy restrictions categorized by type.
    Helps understand what aspects of cluster creation are controlled.
  EOT
  value = {
    fixed_values = {
      for k, v in jsondecode(
        try(tostring(databricks_cluster_policy.this.definition),
        jsonencode(databricks_cluster_policy.this.definition))
      ) : k => v if try(v.type, "") == "fixed"
    }
    allowed_values = {
      for k, v in jsondecode(
        try(tostring(databricks_cluster_policy.this.definition),
        jsonencode(databricks_cluster_policy.this.definition))
      ) : k => v if try(v.type, "") == "allowlist"
    }
    denied_values = {
      for k, v in jsondecode(
        try(tostring(databricks_cluster_policy.this.definition),
        jsonencode(databricks_cluster_policy.this.definition))
      ) : k => v if try(v.type, "") == "denylist"
    }
    ranges = {
      for k, v in jsondecode(
        try(tostring(databricks_cluster_policy.this.definition),
        jsonencode(databricks_cluster_policy.this.definition))
      ) : k => v if try(v.type, "") == "range"
    }
  }
}

output "effective_date" {
  description = "Timestamp when the policy was last modified, useful for tracking changes and versioning."
  value       = coalesce(databricks_cluster_policy.this.updated_at, databricks_cluster_policy.this.created_at)
}