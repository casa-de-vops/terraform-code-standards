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

```plaintext
├── workflows
│   ├── production.yml
│   ├── staging.yml
│   └── development.yml
├── versions
│   ├── production.yml
│   ├── staging.yml
│   └── development.yml
├── environments
│   ├── production.tfvars
│   ├── staging.tfvars
│   └── development.tfvars
├── modules
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── compute
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
├── terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   └── provider.tf
└── README.md
```

## Directory Breakdown

- **workflows/**: 
  - Contains pipeline configuration files for CI/CD workflows, typically in `.yml` format.
  - Files like `production.yml`, `staging.yml`, and `development.yml` represent pipeline configurations for different environments.
  - The `workflows` folder **should** be renamed according to the requirements or best practices of the CI/CD tool being used. For example, it can be named `.github/workflows` for GitHub Actions or `.azuredevops` for Azure DevOps.

- **versions/**:
  - Contains versioning files to manage resource module versions across different environments.
  - This directory is designed to be used by the pipeline token replacement task during runtime, allowing different versions of modules to be provided at runtime for different environments.
  - Example files `production.yml`, `staging.yml`, and `development.yml` specify module versions or specific configurations that may differ between environments.

- **environments/**:
  - Contains environment-specific variables files (`.tfvars`) which are used to define different configurations for each environment (e.g., production, staging, development).

- **modules/**:
  - Holds reusable Terraform modules, organized by functionality, such as `network` and `compute`.
  - Each module should include its own `main.tf`, `variables.tf`, and `outputs.tf` to define the resources, variables, and outputs for that specific module.
  - This folder is only needed if there are modules in the project that are local. If using remote modules, the `modules` folder may not be necessary.

- **terraform/**:
  - Contains the main Terraform configuration files.
  - `main.tf` is the primary entry point where you define the infrastructure.
  - `variables.tf` defines input variables.
  - `outputs.tf` defines output values.
  - `backend.tf` is for backend configuration, such as storing the Terraform state remotely.
  - `provider.tf` contains provider configurations.

- **README.md**:
  - A documentation file to describe the project, directory structure, usage instructions, and any relevant details.

A documentation file to describe the project, directory structure, usage instructions, and any relevant details.
[^ back to top ^](#table-of-contents)