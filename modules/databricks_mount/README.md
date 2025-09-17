# Databricks Mount Module

This module manages mount points in Databricks, allowing you to mount cloud storage (S3, Azure Storage, GCS) to DBFS.

## Usage

### AWS S3 Mount

```hcl
module "s3_mount" {
  source = "./modules/databricks_mount"

  name = "my-s3-mount"
  uri  = "s3://my-bucket/path"

  s3_config = {
    bucket_name      = "my-bucket"
    instance_profile = "arn:aws:iam::123456789012:instance-profile/my-profile"
  }
}
```

### Azure Storage Mount

```hcl
module "azure_mount" {
  source = "./modules/databricks_mount"

  name = "my-azure-mount"
  uri  = "abfss://container@storage.dfs.core.windows.net/path"

  azure_config = {
    container_name       = "container"
    storage_account_name = "storage"
    directory           = "/path"
    auth_type           = "SERVICE_PRINCIPAL"
    tenant_id           = "tenant-id"
    client_id           = "client-id"
    client_secret       = "client-secret"
  }
}
```

### Google Cloud Storage Mount

```hcl
module "gcs_mount" {
  source = "./modules/databricks_mount"

  name = "my-gcs-mount"
  uri  = "gs://my-bucket/path"

  gcp_config = {
    bucket_name     = "my-bucket"
    service_account = "service-account@project.iam.gserviceaccount.com"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the mount | `string` | n/a | yes |
| uri | The URI to mount | `string` | n/a | yes |
| s3_config | Configuration for S3 mount | `object` | `null` | no |
| azure_config | Configuration for Azure Storage mount | `object` | `null` | no |
| gcp_config | Configuration for Google Cloud Storage mount | `object` | `null` | no |
| extra_config | Additional configuration options | `map(string)` | `{}` | no |

### S3 Configuration

```hcl
object({
  bucket_name      = string
  instance_profile = optional(string)
  role_arn        = optional(string)
})
```

### Azure Configuration

```hcl
object({
  container_name       = string
  storage_account_name = string
  directory           = optional(string)
  auth_type           = string
  tenant_id           = optional(string)
  client_id           = optional(string)
  client_secret       = optional(string)
})
```

### GCP Configuration

```hcl
object({
  bucket_name     = string
  service_account = string
})
```

## Outputs

| Name | Description |
|------|-------------|
| mount_id | The ID of the mount |
| mount_url | The DBFS URL for the mount point |
| mount | The full mount resource |

## Notes

1. Only one cloud provider configuration (s3_config, azure_config, or gcp_config) should be specified.
2. The mount point will be accessible at `/mnt/<name>` in DBFS.
3. Make sure the necessary authentication is configured:
   - For AWS: Instance profile or IAM role
   - For Azure: Service principal or managed identity
   - For GCP: Service account
4. Mount points are workspace-specific.