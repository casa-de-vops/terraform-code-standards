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

## Domain Specific Files

- Organize Terraform files based on specific domains within your infrastructure, such as networking, compute, and security, or align them with specific solutions like Key Vault, AKS, or App Services. This approach ensures that related configurations are grouped together, making it easier to manage, troubleshoot, and scale individual components or solutions.
- Utilize a structured directory layout that reflects the separation of concerns or solution alignment, ensuring that each domain or solution's files are logically grouped. This organization enhances maintainability and provides clarity when navigating the codebase, especially in complex enterprise environments.

- Example structure:

  ```plaintext
    ├── workflows
    ├── versions
    ├── modules
    └── terraform
        ├── locals.tf
        ├── backend.tf
        ├── providers.tf
        ├── versions.tf
        ├── variables.tf
        ├── outputs.tf
        ├── keyvault.tf
        ├── aks.tf
        ├── network.tf    
        └── main.tf
    └── pipeline.yaml
  ```

## Directory Breakdown

- If you have locals that are global and your code is split across domain based files then you SHOULD put those locals within a **locals.tf** file. Otherwise, locals blocks SHOULD be declared at the top of your **domain-name.tf** or if a locals block is transforming a specific piece of data and only used a single time it SHOULD be directly above the Resource that is doing the transformation for.
- Use **main.tf** for the terraform block, version constraints, backend configuration, and providers. This file serves as the central point for defining the core setup of your Terraform configuration. By placing these fundamental elements in **main.tf**, you ensure a clear entry point for understanding how Terraform operates within your environment. However, if your configuration becomes complex or if you want to further modularize your setup, you can break out the provider and backend configurations into their own files:
- **provider.tf**: Use this file to declare and configure Terraform providers. This is useful when you have multiple providers or complex provider configurations that you want to manage separately.
- **backend.tf**: Use this file to manage the Terraform backend configuration, especially when your backend setup is complex or subject to frequent changes. This separation helps in maintaining clarity and managing changes more efficiently.


[^ table of contents ^](#table-of-contents)