## Table of Contents

- [Overview](../README.md)
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
- **Standardize input and output names across resources** to ensure consistency and maintainability. Instead of using resource-specific names like `vnet_name` or `keyvault_name`, or `keyvault_id` or `storage_id`, use generic names like `name` or `id` for inputs and outputs. This practice simplifies the configuration, making it easier to manage and reducing the likelihood of confusion when working with multiple resources.
- **Provide default values where appropriate** to simplify the usage of modules and to establish sensible defaults that align with your organization's standards. Default values can reduce the complexity for users by minimizing the number of required inputs, particularly for commonly used settings. For instance, setting a default setting like `public_network_access` to false or a default VM size can streamline the deployment process, and help user comply with organizational policies.
- **Group related variables together** in your Terraform modules to improve readability and organization. For example, group networking-related variables (e.g., `subnet_id`, `vnet_id`, `network_security_group`) together. This makes the module easier to understand and use, as all related configurations are presented together. Use [domain specific files](./domain_specific_files.md) where appropriate.
- **Document each variable** using the `description` field to provide context and usage guidelines. This is particularly important in reusable modules where the end user might not be familiar with the internal details of the module. Clear documentation helps users understand the purpose of each variable and how it should be used, reducing the likelihood of misconfiguration. Use tools like tfdocs to automatically generate documentation for your modules and implement automation to update documentation during the Pull Request process.

  ```hcl
  variable "vnet_name" {
    description = "The name of the Virtual Network"
    type        = string
    default     = "my-vnet"
  }

[^ table of contents ^](#table-of-contents)