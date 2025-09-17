variable "cluster_id" {
  description = "ID of the cluster to install the library on"
  type        = string
}

variable "maven_coordinates" {
  description = "Maven coordinates (groupId:artifactId:version)"
  type        = string
  default     = null
}

variable "maven_repo" {
  description = "Maven repository URL"
  type        = string
  default     = null
}

variable "pypi_package" {
  description = "PyPI package specification"
  type        = string
  default     = null
}

variable "pypi_repo" {
  description = "PyPI repository URL"
  type        = string
  default     = null
}

variable "whl_file" {
  description = "Path to .whl file in DBFS"
  type        = string
  default     = null
}

variable "jar_file" {
  description = "Path to .jar file in DBFS"
  type        = string
  default     = null
}