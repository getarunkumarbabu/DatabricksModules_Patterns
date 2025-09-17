# Databricks Widget Module

This module manages widgets in Databricks notebooks.

## Example Usage

```hcl
# Text Widget
module "text_widget" {
  source = "./modules/databricks_widget"

  notebook_id = "123456"
  position    = 1

  text_widget = {
    value = "Default text value"
  }
}

# Combobox Widget
module "combobox_widget" {
  source = "./modules/databricks_widget"

  notebook_id = "123456"
  position    = 2

  combobox_widget = {
    label         = "Select an option"
    default_value = "option1"
    options       = ["option1", "option2", "option3"]
  }
}

# Multiselect Widget
module "multiselect_widget" {
  source = "./modules/databricks_widget"

  notebook_id = "123456"
  position    = 3

  multiselect_widget = {
    label         = "Select options"
    default_value = ["option1"]
    options       = ["option1", "option2", "option3"]
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

## Resources

| Name | Type |
|------|------|
| [databricks_widget.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/widget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| notebook_id | The ID of the notebook to add the widget to | string | n/a | yes |
| position | The position of the widget in the notebook | number | n/a | yes |
| text_widget | Configuration for a text widget | object | null | no |
| combobox_widget | Configuration for a combobox widget | object | null | no |
| multiselect_widget | Configuration for a multiselect widget | object | null | no |

## Outputs

| Name | Description |
|------|-------------|
| widget_id | ID of the created widget |

## Notes

- Only one widget type can be specified at a time
- Position determines the order of widgets in the notebook