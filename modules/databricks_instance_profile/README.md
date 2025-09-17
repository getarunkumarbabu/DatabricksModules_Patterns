# Databricks Instance Profile Module

This module manages AWS IAM instance profiles in Databricks. It's primarily used in hybrid deployments where Databricks clusters need to access AWS resources.

## Features

- Register AWS IAM instance profiles with Databricks
- Optional validation of IAM role configuration
- Support for meta instance profiles
- Manage instance profile access through infrastructure as code

## Usage

```hcl
module "instance_profile" {
  source = "./modules/databricks_instance_profile"

  instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/my-profile"
  skip_validation      = false
}
```

## Examples

### Basic Instance Profile Registration

```hcl
module "s3_access_profile" {
  source = "./modules/databricks_instance_profile"

  instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/s3-access"
}
```

### Meta Instance Profile

```hcl
module "meta_profile" {
  source = "./modules/databricks_instance_profile"

  instance_profile_arn      = "arn:aws:iam::123456789012:instance-profile/meta-profile"
  is_meta_instance_profile = true
}
```

### Skip Validation

```hcl
module "custom_profile" {
  source = "./modules/databricks_instance_profile"

  instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/custom-profile"
  skip_validation      = true
}
```

## Requirements

- Databricks provider configured with workspace access
- AWS IAM instance profile already created
- Appropriate permissions to manage instance profiles

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| instance_profile_arn | The ARN of the AWS IAM instance profile to register with Databricks | `string` | n/a | yes |
| skip_validation | If set to true, skips validating the IAM role configuration before registering | `bool` | `false` | no |
| is_meta_instance_profile | If set to true, marks this instance profile as a meta instance profile | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_profile_id | The unique identifier for the registered instance profile |
| instance_profile_arn | The ARN of the registered instance profile |
| is_meta_instance_profile | Whether this is a meta instance profile |

## Notes

1. This module is primarily used in AWS deployments or hybrid cloud setups
2. Instance profiles must be created in AWS IAM before registration
3. The IAM role must have the necessary trust relationships configured
4. Meta instance profiles have special permissions and should be used carefully

## Best Practices

1. Always validate IAM role configurations unless there's a specific reason not to
2. Use descriptive names for instance profiles
3. Follow principle of least privilege when configuring IAM roles
4. Document the purpose and permissions of each instance profile
5. Regularly audit instance profile usage and permissions