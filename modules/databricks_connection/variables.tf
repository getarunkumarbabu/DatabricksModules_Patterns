variable "name" {
  description = <<-EOT
    Name of the connection. Must be unique within the workspace.
    Should be descriptive and indicate the purpose or source system.
    Examples: "prod-mysql-analytics", "snowflake-finance", "azure-sql-customer-data"
  EOT
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.name))
    error_message = "Connection name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "connection_type" {
  description = <<-EOT
    Type of the connection. Supported types:
    - MYSQL: MySQL database
    - POSTGRESQL: PostgreSQL database
    - SQLSERVER: Microsoft SQL Server
    - SYNAPSE: Azure Synapse Analytics
    Each type requires specific options to be configured.
  EOT
  type        = string

  validation {
    condition = contains([
      "MYSQL", "POSTGRESQL", "SQLSERVER", "SYNAPSE"
    ], var.connection_type)
    error_message = "Invalid connection type. Must be one of: MYSQL, POSTGRESQL, SQLSERVER, SYNAPSE."
  }
}

variable "comment" {
  description = <<-EOT
    Description of the connection's purpose, usage, and any special considerations.
    Best practices:
    - Document connection purpose
    - Note access requirements
    - List any usage restrictions
    - Specify environment (prod/dev)
    - Include support contact
  EOT
  type        = string
  default     = null
}

variable "owner" {
  description = <<-EOT
    Owner of the connection. Can be:
    - Username
    - Service principal
    - Group name
    The owner has full control over the connection and can modify its settings.
  EOT
  type        = string
  default     = null
}

variable "properties" {
  description = <<-EOT
    Additional properties for the connection. Common properties include:
    - environment: prod/dev/test
    - team: owning team
    - cost_center: billing information
    - data_classification: security level
    - support_contact: team/person to contact
    - last_reviewed: date of last configuration review
  EOT
  type        = map(string)
  default     = null
}

variable "options" {
  description = <<-EOT
    Connection-specific options. Required fields vary by connection_type:

    MYSQL/POSTGRESQL:
    - host: Server hostname
    - port: Server port (3306 for MySQL, 5432 for PostgreSQL)
    - database: Database name
    - user: Username
    - password: Password
    - encrypt: Enable SSL/TLS (recommended)

    SQLSERVER:
    - host: Server name
    - port: Port (default 1433)
    - database: Database name
    - user: Username
    - password: Password
    - encrypt: Enable encryption
    - trust_server_certificate: Trust server SSL cert

    SYNAPSE:
    - host: Server endpoint
    - database: Database name
    - user: Username
    - password: Password
    - authentication: SQL or Active Directory
  EOT
  type = object({
    host                     = optional(string)
    port                     = optional(number)
    database                 = optional(string)
    user                     = optional(string)
    password                 = optional(string)
    encrypt                  = optional(bool)
    trust_server_certificate = optional(bool)
    authentication           = optional(string)
    role                     = optional(string)
    warehouse                = optional(string)
  })
  default   = null
  sensitive = true

  validation {
    condition = var.options == null || (
      var.options.port == null || (
        var.options.port > 0 && var.options.port < 65536
      )
    )
    error_message = "Port number must be between 1 and 65535."
  }

  validation {
    condition = var.options == null || (
      var.options.host == null || (
        can(regex("^[a-zA-Z0-9.-]+$", var.options.host))
      )
    )
    error_message = "Host must be a valid hostname or IP address."
  }
}