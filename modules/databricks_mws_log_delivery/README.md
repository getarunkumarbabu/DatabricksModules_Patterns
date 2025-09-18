# Databricks Log Delivery Module

This module manages log delivery configurations for Azure Databricks. It allows you to configure the delivery of audit logs and billable usage logs to an Azure Storage Account.

## Usage

```hcl
module "databricks_log_delivery" {
  source = "./modules/databricks_mws_log_delivery"

  account_id               = "123456789"
  config_name             = "audit-logs"
  storage_configuration_id = module.storage_config.storage_configuration_id
  credentials_id          = module.credentials.credentials_id

  log_type             = "AUDIT_LOGS"
  output_format        = "JSON"
  delivery_path_prefix = "logs/audit"
  delivery_start_time  = "2025-01-01T00:00:00Z"
  status               = "ENABLED"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| databricks | >= 1.0.0 |
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account_id | Databricks account ID | `string` | n/a | yes |
| config_name | Name of the log delivery configuration | `string` | n/a | yes |
| storage_configuration_id | ID of the storage configuration to use | `string` | n/a | yes |
| log_type | Type of logs to deliver (BILLABLE_USAGE, AUDIT_LOGS) | `string` | n/a | yes |
| output_format | Format of the log output (JSON, CSV) | `string` | `"JSON"` | no |
| delivery_path_prefix | Prefix path where logs will be delivered | `string` | n/a | yes |
| delivery_start_time | Start time for log delivery (RFC3339 format) | `string` | n/a | yes |
| status | Status of the log delivery configuration | `string` | `"ENABLED"` | no |
| credentials_id | ID of the credentials to use for log delivery | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| log_delivery_configuration_id | ID of the created log delivery configuration |
| status | Current status of the log delivery configuration |
| creation_time | Time when the configuration was created |
| config_name | Name of the log delivery configuration |

## Example: Audit Logs Configuration

```hcl
module "audit_logs" {
  source = "./modules/databricks_mws_log_delivery"

  account_id               = var.databricks_account_id
  config_name             = "audit-logs"
  storage_configuration_id = module.storage_config.storage_configuration_id
  credentials_id          = module.credentials.credentials_id

  log_type             = "AUDIT_LOGS"
  output_format        = "JSON"
  delivery_path_prefix = "logs/audit"
  delivery_start_time  = timeadd(timestamp(), "24h")
  status               = "ENABLED"
}
```

## Example: Billable Usage Logs Configuration

```hcl
module "billable_usage_logs" {
  source = "./modules/databricks_mws_log_delivery"

  account_id               = var.databricks_account_id
  config_name             = "billing-logs"
  storage_configuration_id = module.storage_config.storage_configuration_id
  credentials_id          = module.credentials.credentials_id

  log_type             = "BILLABLE_USAGE"
  output_format        = "CSV"
  delivery_path_prefix = "logs/billing"
  delivery_start_time  = timeadd(timestamp(), "24h")
  status               = "ENABLED"
}