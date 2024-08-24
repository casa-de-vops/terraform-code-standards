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

## Modules

- **Write reusable modules with clear input and output definitions** to ensure that your Terraform configurations are modular, maintainable, and easy to understand. Reusable modules help in standardizing infrastructure deployments across different projects and environments.

- **Leverage the Terraform Azure Verified Modules (AVM) Library** for pre-built, tested, and verified modules specifically designed for Azure infrastructure. These modules are curated by Microsoft and its partners, ensuring they adhere to best practices and are optimized for Azure. Using these verified modules can save time, reduce errors, and ensure that your deployments are aligned with Azure's best practices. [Find more information here](https://azure.github.io/Azure-Verified-Modules/).

- **Store modules in a centralized location,** such as a version-controlled repository like GitHub, Azure Repos, or an internal registry. This allows teams to share and reuse modules across different projects, promoting consistency and reducing duplication of effort. For instance, you can manage custom modules and Azure Verified Modules together, making it easier to maintain and update them.

- **Version your modules appropriately** to ensure that changes can be tracked and managed effectively. By versioning your modules, you can control when and how updates are applied across different environments. This is particularly important when using modules from the AVM Library, as you may need to pin specific versions to ensure compatibility with your infrastructure.

- **Customize and Extend AVM Modules** by passing specific values to input variables or by composing multiple modules together to fit your specific use cases. The flexibility of Terraform combined with the reliability of AVM modules provides a powerful way to manage complex Azure environments.

- **Evaluate whether a new module is needed** refer to this [blog post](https://brendanthompson.com/posts/2020/terraform-to-module-or-not-to-module) for Brendan Thompson  9 rules to help guide Terraform developers/engineers assess whether to create a new module or use base/naked resource calls to build your solution.

  1. If a resource MUST have security/audit/compliance controls enforced at provision and/or configuration time, this MUST then be encapsulated within a Terraform module. Otherwise, it SHOULD be consumed as a Terraform resource.
  2. When specific configuration or metadata MUST be applied to a resource it MUST then be created as a Terraform module to enforce those requirements.
  3. When a resource has a stringent/complex naming required that MUST be adhered to these resource MUST be created as a Terraform module.
  4. When a resource relies on information/metadata/context that cannot be known by the consumer it MUST be created as a Terraform module.
  5. If a Terraform module will reduce the complexity of either the configuration or its interface then a Terraform module SHOULD be used.
  6. Resources that have an aligned business purpose/requirement SHOULD be grouped together as a Terraform module.
  7. Resources that MUST satisfy multiple use cases SHOULD be created as a Terraform module.
  8. When a group of resources shares a similar lifecycle they SHOULD be grouped together as a Terraform module.
  9. If a resource is always going to be consumed by a higher-order module it SHOULD NOT be created as a bare/wrapper Terraform module

By following these practices and leveraging the Azure Verified Modules Library, you can ensure that your Terraform modules are robust, reusable, and aligned with industry standards, helping to simplify the management of your Azure infrastructure.

[^ table of contents ^](#table-of-contents)