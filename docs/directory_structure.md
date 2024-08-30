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

## Directory Structure

- Organize Terraform configuration and workflows logically to separate environments, stages, and manage resource module versioning.
- Example structure:

  ```plaintext
    ├── workflows
    │   └── template.yml
    ├── versions
    │   ├── modules.prod.yml
    │   ├── modules.stage.yml
    │   └── modules.dev.yml
    ├── environments
    │   ├── prod.tfvars
    │   ├── stage.tfvars
    │   └── dev.tfvars
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
    └── pipeline.development.yaml
    └── pipeline.staging.yaml
    └── pipeline.production.yaml
  ```

## Directory Breakdown

- **workflows/**:
  - Contains reusable pipeline configuration files that can be run by environments for CI/CD workflows, typically in `.yml` format.
  - The `workflows` folder **should** be renamed according to the requirements or best practices of the CI/CD tool being used. For example, it can be named `.github/workflows` for GitHub Actions or `.azuredevops` for Azure DevOps.
  - This folder is only needed if the workflow yml templates in this project are local. If using remote workflows, like shown in the [example](../pipeline.deploy.yaml) workflow, the `workflow` folder may not be necessary.

- **./pipeline.yaml trigger files**: 
  - Contains trigger yaml files representing actual deployment pipelines. These can be structured to run a single environment, or a set or environments.
  - These files sit at the root of the directory and can either call a local workflows folder, or a remote set of workflows, in the a remote workflow can be setup [example](../.azuredevops/tests/pipeline.yaml) workflow.
  - Files like `pipeline.production.yaml`, `pipeline.staging.yaml`, and `pipeline.development.yaml.yml` represent pipeline entrypoints for deployment for different environments. When configuring Azure DevOps pipelines, point it to one of these yaml files.

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
[^ table of contents ^](#table-of-contents)
