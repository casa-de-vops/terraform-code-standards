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

## Directory Structure

- Organize Terraform configuration and workflows logically to separate environments, stages, and manage resource module versioning.
- Example structure:
  ```
    ├── workflows
    │   ├── production.yml
    │   └── non-production.yml
    ├── versions
    │   ├── production.yml
    │   └── staging.yml
    │   └── development.yml
    ├── environments
    │   ├── production.tfvars
    │   └── staging.tfvars
    │   └── development.tfvars
    ├── modules
    │   ├── network
    │   └── compute
    └── terraform
        └── main.tf
  ```

[^ back to top ^](#table-of-contents)