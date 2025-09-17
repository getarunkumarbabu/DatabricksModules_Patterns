variable "path" {
  description = "The workspace path where the directory should be created. Must start with /Shared, /Users, or /Repos"
  type        = string

  validation {
    condition = can(regex("^/(Shared|Users|Repos)/", var.path))
    error_message = "Directory path must start with /Shared, /Users, or /Repos."
  }

  validation {
    condition = can(regex("^[/a-zA-Z0-9_\\- ]+$", var.path))
    error_message = "Directory path can only contain alphanumeric characters, underscores, hyphens, spaces, and forward slashes."
  }
}