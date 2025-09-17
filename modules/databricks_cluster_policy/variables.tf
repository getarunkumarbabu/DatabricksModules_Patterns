variable "name" {
  description = "Name of the cluster policy. Must be unique within the workspace and descriptive of the policy's purpose."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_. ]+$", var.name))
    error_message = "Policy name can only contain alphanumeric characters, dashes, underscores, periods, and spaces."
  }
}

variable "description" {
  description = <<-EOT
    Description of the cluster policy. Should clearly explain:
    - Purpose and intended use
    - Key restrictions or allowances
    - Any special considerations
    - Target user groups
  EOT
  type        = string
  default     = null
}

variable "definition" {
  description = <<-EOT
    Policy definition as a JSON string or map. Common fields include:
    - spark_version: Runtime version restrictions
    - node_type_id: Allowed node types
    - driver_node_type_id: Allowed driver node types
    - autotermination_minutes: Idle timeout limits
    - custom_tags: Required or prohibited tags
    - spark_conf: Spark configuration restrictions
    - instance_pool_id: Instance pool requirements
    - aws_attributes: AWS-specific constraints
    - azure_attributes: Azure-specific constraints
    - gcp_attributes: GCP-specific constraints

    Each field can use these policy types:
    - fixed: Enforces a specific value
    - allowlist: Permits only specified values
    - denylist: Forbids specified values
    - unlimited: Allows any value
    - range: Enforces numeric bounds
  EOT
  type        = any

  validation {
    condition     = try(
      jsondecode(
        try(tostring(var.definition), jsonencode(var.definition))
      ),
      false
    ) != false
    error_message = "The definition must be a valid JSON object or string."
  }
}

variable "max_clusters_per_user" {
  description = <<-EOT
    Maximum number of clusters that each user can create using this policy.
    Use this to control resource consumption and costs. Set to null for unlimited.
  EOT
  type        = number
  default     = null

  validation {
    condition     = var.max_clusters_per_user == null || var.max_clusters_per_user > 0
    error_message = "max_clusters_per_user must be greater than 0 if specified."
  }
}

variable "policy_family_id" {
  description = <<-EOT
    ID of the policy family to extend. Policy families provide base configurations that can be extended.
    Common families:
    - "default" - Basic policy with standard limits
    - "data-science" - Optimized for ML workloads
    - "etl" - Configured for data processing
    - "analytics" - Tuned for BI and reporting
  EOT
  type        = string
  default     = null
}

variable "policy_family_overrides" {
  description = <<-EOT
    Map of overrides to apply when extending a policy family. Each key-value pair
    represents a field to override in the base policy family definition.
    Example:
    {
      "spark_version.value": "11.3.x-scala2.12",
      "node_type_id.values": ["Standard_DS3_v2", "Standard_DS4_v2"]
    }
  EOT
  type        = map(any)
  default     = {}
}

variable "libraries" {
  description = <<-EOT
    Libraries to be installed on all clusters using this policy.
    Supported formats:
    - jar: JAR files (e.g., "dbfs:/libraries/custom.jar")
    - egg: Python egg files
    - whl: Python wheel files
    - pypi: PyPI packages with optional version (e.g., "scikit-learn==1.0.2")
    - maven: Maven coordinates with optional repository and exclusions
    - cran: R packages from CRAN

    Note: Ensure all specified libraries are compatible with the policy's allowed Spark versions.
  EOT
  type = object({
    jar = optional(list(string))
    egg = optional(list(string))
    whl = optional(list(string))
    pypi = optional(list(string))
    maven = optional(list(object({
      coordinates = string
      repo       = optional(string)
      exclusions = optional(list(string))
    })))
    cran = optional(list(string))
  })
  default = null

  validation {
    condition = var.libraries == null || (
      (var.libraries.jar == null || alltrue([for j in coalesce(var.libraries.jar, []) : can(regex("^(dbfs:|s3:|abfss:|gs:)/", j))])) &&
      (var.libraries.egg == null || alltrue([for e in coalesce(var.libraries.egg, []) : can(regex("^(dbfs:|s3:|abfss:|gs:)/", e))])) &&
      (var.libraries.whl == null || alltrue([for w in coalesce(var.libraries.whl, []) : can(regex("^(dbfs:|s3:|abfss:|gs:)/", w))]))
    )
    error_message = "Library paths must start with a valid scheme (dbfs:, s3:, abfss:, gs:)."
  }
}