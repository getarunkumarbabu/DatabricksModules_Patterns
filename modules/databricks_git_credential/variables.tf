variable "git_username" {
  description = "The Git username for the credential"
  type        = string
}

variable "git_provider" {
  description = "The Git provider (e.g., gitHub, gitLab, azureDevOpsServices, bitbucketCloud)"
  type        = string
  validation {
    condition     = contains(["gitHub", "gitLab", "azureDevOpsServices", "bitbucketCloud"], var.git_provider)
    error_message = "Git provider must be one of: gitHub, gitLab, azureDevOpsServices, bitbucketCloud."
  }
}

variable "personal_access_token" {
  description = "The personal access token for Git authentication"
  type        = string
  sensitive   = true
}

variable "force" {
  description = "Force update the credential even if it exists"
  type        = bool
  default     = false
}