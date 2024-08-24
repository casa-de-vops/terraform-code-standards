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

## Azure Resource Naming Conventions

- **Use consistent naming conventions for all Azure resources** to ensure clarity, manageability, and compliance with best practices. A well-defined naming convention should help identify the resource type, its associated workload, environment, and location.

- **Standardize Naming with Terraform Modules:**
  - Utilize naming modules like the [Cloud Posse Null Label Module](https://github.com/cloudposse/terraform-null-label) and the [Azure CAF Naming Module](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name) to enforce consistent naming conventions across all resources. These modules simplify the process of generating descriptive, standardized names by consolidating naming logic into reusable components that adhere to best practices.
  - **Key Features:**
    - **Consistency Across Environments:** Ensure that resource names are standardized across different environments and services, following a consistent format.
    - **Automated Naming Logic:** Automatically generate resource names based on predefined rules, reducing the chance of human error and enhancing the maintainability of your infrastructure.
    - **Simplified Implementation:** Streamline the application of complex naming conventions by using these modules, especially in large or multi-environment setups.
    - **Enhanced Collaboration:** Provide a consistent naming schema that all team members can follow, improving collaboration and reducing confusion.

- **Apply naming patterns consistently across all environments and stages** to maintain predictability and ease of management. Consistency in naming helps in resource identification, management, and automation.

- **Examples of Azure Naming Patterns:**
  - **Resource Group:** `rg-acctlookupsvc-shared-prod-westus-001` 
  - **Virtual Network:** `vnet-prod-westus-001`
  - **Public IP Address:** `pip-sharepoint-prod-westus-001`
  
For detailed guidance on constructing Azure naming conventions, refer to the [Azure Cloud Adoption Framework (CAF)](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming). For standardized abbreviations and further guidance on Terraform resource naming, see the [Recommended abbreviations for Azure resource types](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/azure-best-practices/resource-abbreviations.md).
  
[^ table of contents ^](#table-of-contents)

## Terraform Symbolic Naming Conventions

- **Use consistent naming conventions for Terraform resources, variables, and outputs** to ensure clarity and maintainability across your Terraform configurations. Terraform symbolic names should be descriptive yet concise, reflecting the purpose and type of resource they represent.

- **Standardize inputs and outputs choosing simple and identifiable keys like `name` or `id`** rather than resource-specific terms like `vnet_name` or `keyvault_id`. This approach ensures that variables and outputs are generic and reusable, making the codebase easier to maintain and extend. For example:
  - Use `name` instead of `vnet_name` or `keyvault_name`
  - Use `id` instead of `vnet_id` or `keyvault_id`

- **Use simple yet descriptive symbolic names for reusable Terraform modules code** to enhance readability and maintainability. For example:
  - `azurerm_virtual_network.this` for a general-purpose virtual network resource.
  - `azurerm_role_assignment.network_contributor_on_vnet` for a role assignment specific to network contributors on a virtual network.

- **Examples of Terraform Symbolic Naming Patterns:**
  - **Terraform Resource Name:** `azurerm_virtual_network.external`
  - **Variable Name:** `azurerm_virtual_network.external.name` instead of `azurerm_virtual_network.external.vnet_name`
  - **Output Name:** `azurerm_virtual_network.external.id` instead of `azurerm_virtual_network.external.vnet_id`
 
[^ table of contents ^](#table-of-contents)
