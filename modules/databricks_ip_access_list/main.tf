resource "databricks_ip_access_list" "this" {
  label        = var.label
  list_type    = var.list_type
  ip_addresses = var.ip_addresses
  enabled      = var.enabled

  lifecycle {
    precondition {
      condition = alltrue([
        for ip in var.ip_addresses : 
        can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}(?:/[0-9]{1,2})?$", ip)) ||
        can(regex("^(?:[A-F0-9]{1,4}:){7}[A-F0-9]{1,4}(?:/[0-9]{1,3})?$", ip))
      ])
      error_message = "All IP addresses must be valid IPv4 CIDR blocks (e.g., 10.0.0.0/24) or IPv6 addresses."
    }
  }
}