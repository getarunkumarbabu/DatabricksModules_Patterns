variable "group_id" {
  description = "The ID of the group to add the member to"
  type        = string
}

variable "member_id" {
  description = "The ID of the user or service principal to add to the group"
  type        = string
}