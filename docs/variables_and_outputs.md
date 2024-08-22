## Table of Contents

- [Overview](../README.md)
- Coding Standards
  - [Directory Structure](./directory_structure.md)
  - [Domain Specific Files](./domain_specific_files.md)
  - [Naming Conventions](./naming_conventions.md#naming-conventions)
  - [Resource and State Management](./resource_and_state_management.md)
  - [Modules](./module.md)
  - [Variables and Outputs](./variables_and_outputs.md)
  - [Version Control](./version_control.md)
  - [Documentation](./documentation.md)
  - [Testing and Validation](./testing_and_validation.md)

## Variables and Outputs
- **Use descriptive names for variables** to ensure clarity and maintainability. Each variable name should clearly indicate its purpose and the resource it is associated with. For example, instead of naming a variable `name`, use a more descriptive name like `vnet_name` or `storage_account_name` to reflect the specific resource the variable pertains to. This practice helps avoid confusion, especially in complex configurations with multiple resources.
- **Provide default values where appropriate** to simplify the usage of modules and to establish sensible defaults that align with your organization's standards. Default values can reduce the complexity for users by minimizing the number of required inputs, particularly for commonly used settings. For instance, setting a default region like `eastus` or a default VM size can streamline the deployment process.
- **Group related variables together** in your Terraform modules to improve readability and organization. For example, group networking-related variables (e.g., `subnet_id`, `vnet_id`, `network_security_group`) together. This makes the module easier to understand and use, as all related configurations are presented together.
- **Document each variable** using the `description` field to provide context and usage guidelines. This is particularly important in reusable modules where the end user might not be familiar with the internal details of the module. Clear documentation helps users understand the purpose of each variable and how it should be used, reducing the likelihood of misconfiguration.

  ```hcl
  variable "vnet_name" {
    description = "The name of the Virtual Network"
    type        = string
    default     = "my-vnet"
  }

[^ back to overview ^](../README.md)