variable "cluster_id" {
  description = "ID of the Databricks cluster to apply access control rules to"
  type        = string
  validation {
    condition     = length(var.cluster_id) > 0
    error_message = "The cluster_id cannot be empty."
  }
}

variable "access_rules" {
  description = "List of access control rules"
  type = list(object({
    principal        = string
    permission_level = string
  }))
  validation {
    condition = alltrue([
      for rule in var.access_rules :
      contains(["CAN_MANAGE", "CAN_ATTACH_TO", "CAN_RESTART"], rule.permission_level)
    ])
    error_message = "Each permission_level must be one of: CAN_MANAGE, CAN_ATTACH_TO, CAN_RESTART."
  }
  validation {
    condition = alltrue([
      for rule in var.access_rules :
      length(rule.principal) > 0
    ])
    error_message = "Each principal must not be empty."
  }
}