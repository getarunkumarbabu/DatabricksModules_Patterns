# Databricks MLflow Webhook Module

This module manages MLflow webhooks in Databricks, allowing you to trigger actions in response to MLflow events.

## Features

- Configure webhooks for MLflow model registry events
- Support for HTTP endpoints and Databricks jobs as webhook targets
- Customizable event triggers
- SSL verification for HTTP endpoints
- Optional authorization headers

## Usage

```hcl
module "mlflow_webhook" {
  source = "./modules/databricks_mlflow_webhook"

  events      = ["MODEL_VERSION_CREATED", "REGISTERED_MODEL_CREATED"]
  description = "Notify when new models are registered"
  
  http_url_spec = {
    url = "https://example.com/webhook"
    authorization_header = "Bearer token123"
  }
}
```

## Examples

### HTTP Webhook

```hcl
module "notification_webhook" {
  source = "./modules/databricks_mlflow_webhook"

  events      = ["MODEL_VERSION_TRANSITIONED_STAGE"]
  description = "Send notification when model stage changes"
  
  http_url_spec = {
    url = "https://api.notification-service.com/mlflow"
    enable_ssl_verification = true
    authorization_header = "Bearer ${var.api_token}"
  }
}
```

### Job Trigger Webhook

```hcl
module "retraining_webhook" {
  source = "./modules/databricks_mlflow_webhook"

  events      = ["MODEL_VERSION_TRANSITIONED_STAGE"]
  description = "Trigger model retraining on production deployment"
  
  job_spec = {
    job_id = databricks_job.retraining.id
  }
}
```

## Requirements

- Databricks provider configured with workspace access
- Appropriate permissions to manage MLflow webhooks
- Valid webhook target (HTTP endpoint or Databricks job)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| events | List of events that trigger the webhook | `list(string)` | n/a | yes |
| description | Description of the webhook's purpose | `string` | `null` | no |
| status | Status of the webhook (ACTIVE or DISABLED) | `string` | `"ACTIVE"` | no |
| job_spec | Configuration for triggering a Databricks job | `object` | `null` | no |
| http_url_spec | Configuration for HTTP webhook endpoint | `object` | `null` | no |
| registry_webhook | Whether this is a registry webhook | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| webhook_id | The unique identifier for the MLflow webhook |
| webhook_status | The current status of the webhook |
| webhook_events | The list of events that trigger the webhook |
| webhook_url | The HTTP URL endpoint of the webhook |
| job_id | The ID of the job to trigger |
| created_at | The timestamp when the webhook was created |
| updated_at | The timestamp when the webhook was last updated |

## Notes

1. Only one target type (http_url_spec or job_spec) should be specified
2. Available events include:
   - MODEL_VERSION_CREATED
   - MODEL_VERSION_TRANSITIONED_STAGE
   - REGISTERED_MODEL_CREATED
   - MODEL_VERSION_TAG_SET
   - REGISTERED_MODEL_TAG_SET
3. Consider security implications when using HTTP webhooks
4. Webhooks can be temporarily disabled without deletion

## Best Practices

1. Use descriptive names and descriptions
2. Implement proper security for HTTP endpoints
3. Monitor webhook activity and failures
4. Use SSL verification for HTTP endpoints
5. Regularly audit webhook configurations