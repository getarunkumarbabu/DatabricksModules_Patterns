variable "instance_profile_arn" {
  description = "The ARN of the AWS IAM instance profile to register with Databricks"
  type        = string
}

variable "skip_validation" {
  description = "If set to true, skips validating the IAM role configuration before registering the instance profile"
  type        = bool
  default     = false
}

variable "is_meta_instance_profile" {
  description = "If set to true, marks this instance profile as a meta instance profile"
  type        = bool
  default     = false
}