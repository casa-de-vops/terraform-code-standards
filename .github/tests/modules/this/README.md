# Terraform Module: Generic Azure Resource

This Terraform module provisions a generic Azure resource. It can be customized to deploy various Azure services by adjusting the resource type and configuration.

## Usage

```hcl
module "example_resource" {
  source              = "github.com/your-organization/terraform-azure-module"
  resource_name       = "example-resource"
  resource_group_name = "example-resource-group"
  location            = "East US"
  tags                = {
    environment = "production"
    project     = "example-project"
  }

  # Additional resource-specific inputs
}
```

## Requirements

| Name      | Version |
|-----------|---------|
| Terraform | >= 1.0  |
| AzureRM   | >= 3.0  |

## Providers

| Name    | Version |
|---------|---------|
| azurerm | >= 3.0  |

## Inputs

| Name                  | Description                                                      | Type          | Default        | Required |
|-----------------------|------------------------------------------------------------------|---------------|----------------|----------|
| `name`                | The name of the resource to create.                              | `string`      | n/a            | yes      |
| `resource_group_name` | The name of the resource group in which to create the resource.  | `string`      | n/a            | yes      |
| `location`            | The Azure region where the resource should be created.           | `string`      | `"westus"`     | yes      |
| `tags`                | A mapping of tags to assign to the resource.                     | `map(string)` | `{}`           | no       |