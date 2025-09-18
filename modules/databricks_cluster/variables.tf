variable "cluster_name" {
  description = "Name of the Databricks cluster. Must be unique within the workspace. May only contain alphanumeric characters, dashes, underscores, periods, and spaces."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_. ]+$", var.cluster_name))
    error_message = "The cluster name can only contain alphanumeric characters, dashes, underscores, periods, and spaces."
  }
}

variable "spark_version" {
  description = "Spark runtime version. Use format like '12.2.x-scala2.12', '13.0.x-cpu-ml-scala2.12', etc."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.x(-[a-zA-Z0-9-]+)*$", var.spark_version))
    error_message = "The spark_version must be in format like '12.2.x-scala2.12' or '13.0.x-cpu-ml-scala2.12'."
  }
}

variable "node_type_id" {
  description = "Azure VM type ID for worker nodes. Example: 'Standard_DS3_v2', 'Standard_F8s_v2', etc."
  type        = string

  validation {
    condition     = can(regex("^Standard_[A-Za-z0-9]+_v[0-9]$", var.node_type_id))
    error_message = "The node_type_id must be a valid Azure VM type (e.g., Standard_DS3_v2)."
  }
}

variable "driver_node_type_id" {
  description = "Azure VM type ID for the driver node. If not specified, the worker node type will be used."
  type        = string
  default     = null

  validation {
    condition     = var.driver_node_type_id == null || can(regex("^Standard_[A-Za-z0-9]+_v[0-9]$", var.driver_node_type_id))
    error_message = "The driver_node_type_id must be a valid Azure VM type (e.g., Standard_DS3_v2)."
  }
}

variable "instance_pool_id" {
  description = "ID of the instance pool to use for cluster nodes. If specified, node_type_id will be ignored."
  type        = string
  default     = null
}

variable "policy_id" {
  description = "ID of the cluster policy to use. The policy may override other configurations."
  type        = string
  default     = null
}

variable "num_workers" {
  description = "Number of workers for fixed-size clusters. Cannot be specified with autoscale_config."
  type        = number
  default     = null

  validation {
    condition     = var.num_workers == null || var.num_workers > 0
    error_message = "Number of workers must be greater than 0 if specified."
  }
}

variable "autoscale_config" {
  description = "Autoscale configuration. Cannot be specified with num_workers."
  type = object({
    min_workers = number
    max_workers = number
  })
  default = null

  validation {
    condition = var.autoscale_config == null || (
      var.autoscale_config.min_workers > 0 &&
      var.autoscale_config.max_workers >= var.autoscale_config.min_workers
    )
    error_message = "min_workers must be > 0 and max_workers must be >= min_workers."
  }
}

variable "autotermination_minutes" {
  description = "Minutes of inactivity before automatically terminating the cluster. Set to 0 to disable."
  type        = number
  default     = 60

  validation {
    condition     = var.autotermination_minutes >= 0
    error_message = "Autotermination minutes must be >= 0."
  }
}

variable "enable_elastic_disk" {
  description = "Enable elastic disk optimization to automatically scale disk size based on usage."
  type        = bool
  default     = true
}

variable "enable_local_disk_encryption" {
  description = "Enable local disk encryption. Requires cluster security mode to be USER_ISOLATION."
  type        = bool
  default     = false
}

variable "spark_conf" {
  description = "Map of Spark configurations. Example: {'spark.databricks.delta.preview.enabled': 'true'}"
  type        = map(string)
  default     = {}
}

variable "spark_env_vars" {
  description = "Map of environment variables to set for Spark. Example: {'PYSPARK_PYTHON': '/databricks/python3/bin/python3'}"
  type        = map(string)
  default     = {}
}

variable "custom_tags" {
  description = "Custom tags to identify and categorize cluster resources."
  type        = map(string)
  default     = {}
}

variable "workload_config" {
  description = "Workload-specific configurations for specialized compute needs."
  type = object({
    workload_type = string # e.g., "ML", "ETL", "REPORTING"
    configuration = map(string)
  })
  default = null

  validation {
    condition     = var.workload_config == null || contains(["ML", "ETL", "REPORTING"], var.workload_config.workload_type)
    error_message = "workload_type must be one of: ML, ETL, REPORTING."
  }
}

variable "init_scripts" {
  description = "List of initialization scripts to run on cluster startup. Paths must be in DBFS."
  type = list(object({
    destination = string
  }))
  default = null

  validation {
    condition = var.init_scripts == null || alltrue([
      for script in var.init_scripts : can(regex("^dbfs:/.*", script.destination))
    ])
    error_message = "Init script destinations must start with 'dbfs:/'."
  }
}

variable "libraries" {
  description = "Libraries to install on cluster startup. Currently supports jar and whl libraries only."
  type = list(object({
    jar = optional(string)
    whl = optional(string)
  }))
  default = null

  validation {
    condition = var.libraries == null || alltrue([
      for lib in var.libraries : (lib.jar != null || lib.whl != null)
    ])
    error_message = "At least one library type (jar or whl) must be specified for each library entry."
  }
}

variable "cluster_log_conf" {
  description = "Cluster log delivery configuration for file destinations."
  type = object({
    destination = string # DBFS destination path starting with dbfs:/
  })
  default = null

  validation {
    condition     = var.cluster_log_conf == null || can(regex("^dbfs:/", var.cluster_log_conf.destination))
    error_message = "Log destination must start with 'dbfs:/'."
  }
}

variable "azure_attributes" {
  description = "Azure-specific attributes for cluster instances."
  type = object({
    availability       = optional(string) # ON_DEMAND_AZURE or SPOT_AZURE
    first_on_demand    = optional(number) # Number of initial nodes to run as on-demand
    spot_bid_max_price = optional(number) # Maximum price for spot instances (percentage of on-demand)
  })
  default = null

  validation {
    condition = var.azure_attributes == null || (
      var.azure_attributes.availability == null ||
      contains(["ON_DEMAND_AZURE", "SPOT_AZURE"], var.azure_attributes.availability)
    )
    error_message = "Azure availability must be one of: ON_DEMAND_AZURE, SPOT_AZURE."
  }

  validation {
    condition = var.azure_attributes == null || (
      var.azure_attributes.spot_bid_max_price == null ||
      var.azure_attributes.spot_bid_max_price >= 0
    )
    error_message = "Spot bid max price must be >= 0 (percentage of on-demand price)."
  }

  validation {
    condition = var.azure_attributes == null || (
      var.azure_attributes.first_on_demand == null ||
      var.azure_attributes.first_on_demand >= 0
    )
    error_message = "First on-demand nodes must be >= 0."
  }
}