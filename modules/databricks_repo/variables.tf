variable "url" {
  description = "Git URL of the repository to clone"
  type        = string
}

variable "path" {
  description = "Path where the repository will be mounted in the workspace"
  type        = string
}

variable "branch" {
  description = "Branch to checkout. Conflicts with tag"
  type        = string
  default     = null
}

variable "tag" {
  description = "Tag to checkout. Conflicts with branch"
  type        = string
  default     = null
}