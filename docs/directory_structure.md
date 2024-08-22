### Directory Structure

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

[^ back to overview ^](../README.md)