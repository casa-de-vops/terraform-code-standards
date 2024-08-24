## Table of Contents

- [Overview](../README.md)
- [Coding Standards](../README.md#coding-standards)
  - [Directory Structure](./directory_structure.md)
  - [Domain Specific Files](./domain_specific_files.md)
  - [Naming Conventions](./naming_conventions.md#naming-conventions)
  - [Resource and State Management](./resource_and_state_management.md)
  - [Modules](./module.md)
  - [Variables and Outputs](./variables_and_outputs.md)
  - [Version Control](./version_control.md)
  - [Documentation](./documentation.md)
  - [Testing and Validation](./testing_and_validation.md)

## Resource and State Management

- **Define *resource module* within your organization** as the most atomic definition of a single Azure Resource or tightly coupled resources. A resource module encapsulates the creation, management, and configuration of a specific Azure resource, such as a virtual network, storage account, or SQL database. These modules are reusable and serve as building blocks for more complex infrastructure deployments.

- **Define *pattern modules* within your organization** as an orchestration of related Azure resources, adding a layer on top of resource modules that specializes in the resource's governance and defines defaults that align with a use-case specification. Pattern modules are designed to encapsulate common architectural patterns, such as a multi-tier application architecture, integrating various resource modules to meet specific business requirements.

- **Utilize a hierarchical levels approach for state file management** in your Terraform projects, especially in complex enterprise environments. This approach helps manage the complexity of infrastructure, enhances security, and facilitates team autonomy by isolating different concerns into separate state files. The levels model, as recommended by Azure Terraform SRE landing zones, categorizes state files into levels based on different lifecycles, privileges, and organizational needs, see the [Azure Terraform SRE Landing zones for Terraform levels hierarchy overview](https://github.com/aztfmod/documentation/blob/main/website/docs/fundamentals/intro.md).

- **Control the blast radius and enforce the least privilege principle** by segregating state files based on their levels. Each level is protected by its own identity, and access controls are strictly enforced through Azure RBAC. This minimizes the risk of widespread disruption and enhances the security of the overall environment.

- **Enable autonomy and innovation within teams** by providing read-only access to lower-level state files and write access only to the current level. This allows teams to build on existing infrastructure components without risking unauthorized changes to more privileged resources.

- **Implement codeless state reading and enterprise composition** using Azure Terraform SRE and HCL remote-state blocks. These tools provide object models to dynamically load and compose landing zones in memory, enabling sophisticated environment composition and management. By integrating remote-state blocks, you can establish a seamless flow from lower to higher layers, ensuring consistency across environments. This approach allows for strict access controls, maintaining security while facilitating the dynamic composition and management of enterprise environments.
  
- Enable state locking to prevent concurrent modifications.
  
By defining clear resource and pattern modules, and adopting a structured levels hierarchy for state management, your organization can manage complex Azure environments more effectively, enhance security, and enable team autonomy.

[^ back to top ^](#table-of-contents)
