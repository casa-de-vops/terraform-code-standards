## Table of Contents

- [Overview](../../README.md)
- [Azure Github Actions Workflows](../../README.md#azure-github-actions-workflows)

## Terraform CI/CD Orchestration

This workflow is designed to automate the validation, planning, inspection, and application of Terraform configurations. It is parameterized to support various environments, workloads, and Terraform configurations, ensuring reliable and consistent infrastructure deployments.

The deployment workflow manages the deployment of Azure resources using GitHub Actions and Terraform. It is triggered by changes in specific branches, ensuring that the infrastructure is updated automatically.

## Workflow Overview

The Terraform CI/CD Orchestration workflow is triggered to manage the lifecycle of Terraform configurations, ensuring they are validated, reviewed, and applied in a controlled manner.

### Key Features:
- **Validation:** Ensures the Terraform configuration is syntactically correct.
- **Planning:** Generates an execution plan for infrastructure changes.
- **Inspection:** Optionally inspects the plan for compliance or security risks.
- **Application:** Applies the plan to specified environments, with conditional checks to ensure it only runs on selected branches.

## Triggering the Workflow

This workflow can be triggered through various events, such as a push to specific branches or a manual dispatch. Below is an example trigger file:

```yaml
# .github/workflows/trigger.yml
name: Trigger Terraform Orchestration

on:
  push:
    branches:
      - main
      - github_actions
  workflow_dispatch:

permissions:
  contents: read
  id-token: write
  actions: read
  security-events: write

jobs:
  terraform:
    name: Terraform CI/CD Orchestration
    uses: casa-de-vops/terraform-code-standards/.github/workflows/tf_orchestration.yml@main
    secrets: inherit
    with:
      tf_version: 'latest'
      working_directory: 'terraform/'
      environment: 'dev'
      gh_environment: 'nonprod'
      backend_azure_rm_resource_group_name: 'rg-terraform-ops'
      backend_azure_rm_storage_account_name: 'casadevopsterraform'
      backend_azure_rm_container_name: 'ops-terraform-state'
      backend_azure_rm_key: 'pipeline-test.dev.tfstate'
      plan_file_name: 'terraform.tfplan'
      var_file: '../environments/dev.tfvars'
```

## Inputs Description

The workflow can be customized using the following inputs:

| Name                                   | Description                                                                                          | Type     | Default Value      | Required |
|----------------------------------------|------------------------------------------------------------------------------------------------------|----------|--------------------|----------|
| `tf_version`                           | Specifies the Terraform version to use.                                                              | `string` | `'latest'`         | no       |
| `working_directory`                    | The directory where Terraform commands will be executed.                                             | `string` | n/a                | yes      |
| `environment`                          | The deployment environment (e.g., `dev`, `prod`).                                                    | `string` | n/a                | yes      |
| `gh_environment`                       | The GitHub environment, often linked to environment-specific secrets or settings.                    | `string` | n/a                | yes      |
| `backend_azure_rm_resource_group_name` | Azure Resource Group for Terraform state storage.                                                    | `string` | n/a                | yes      |
| `backend_azure_rm_storage_account_name`| Azure Storage Account name where Terraform state is stored.                                          | `string` | n/a                | yes      |
| `backend_azure_rm_container_name`      | Azure Storage container for the state file.                                                          | `string` | n/a                | yes      |
| `backend_azure_rm_key`                 | The key or path within the container for the state file.                                             | `string` | n/a                | yes      |
| `plan_file_name`                       | The name of the Terraform plan file.                                                                 | `string` | `'terraform.tfplan'`| no       |
| `var_file`                             | Specifies a variables file to be used with Terraform commands.                                       | `string` | `''`               | no       |

## Prerequisites

1. **GitHub Permissions:**
   - Ensure the appropriate GitHub permissions are set in your trigger file:
     - `contents: read`
     - `id-token: write`
     - `actions: read`
     - `security-events: write` (if using advanced security features).

2. **Azure Authentication Setup:**
   - **GitHub Actions Environment:**
     - Create a GitHub Actions environment and define the required secrets for authenticating with Azure. This ensures that sensitive information is securely stored and managed.

   - **Federated Credentials (Recommended):**
     - Use [Federated Credentials](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp#configure-a-federated-identity-credential-on-an-app) for secure, passwordless authentication. With federated credentials, store the following secrets in your GitHub Actions environment:
       - `AZURE_CLIENT_ID`: The client ID of the Azure service principal.
       - `AZURE_TENANT_ID`: The tenant ID of your Azure Active Directory.
       - `AZURE_SUBSCRIPTION_ID`: The subscription ID where resources will be managed.
     
   - **Alternative Authentication Methods:**
     - If necessary, you can use other forms of authentication, such as secret-based authentication. For these methods, in addition to the secrets above, also store the following:
       - `AZURE_CLIENT_SECRET`: The client secret of the Azure service principal.
     - These secrets can be used with the [Azure Login GitHub Action](https://github.com/Azure/login#readme) to authenticate during your workflows.

3. **Terraform Installation:**
   - Terraform must be installed on the agent running the workflow.

## Workflow Jobs

### 1. **Validate**
- **Purpose:** Validates the Terraform configuration to ensure there are no syntax errors.
- **Triggers:** Runs before any planning or applying.
- **Job:**
  - Initializes the Terraform environment and runs the validation process.
- **Steps:**
  1. Install Terraform.
  2. Token replacement in configuration files.
  3. Initialize the Terraform environment.
  4. Run `terraform validate` command.

### 2. **Plan**
- **Purpose:** Creates a Terraform execution plan showing the changes that will be made.
- **Triggers:** Runs after successful validation.
- **Job:**
  - Runs Terraform's planning process to create an execution plan.
- **Steps:**
  1. Install Terraform.
  2. Token replacement in configuration files.
  3. Initialize the Terraform environment.
  4. Run `terraform plan` command and save the execution plan as an artifact.

### 3. **Inspect**
- **Purpose:** Inspects the Terraform plan for security or compliance issues.
- **Triggers:** Runs after planning, providing a gate before applying the changes.
- **Job:**
  - Runs security tools to scan the Terraform configuration for vulnerabilities.
- **Steps:**
  1. Run [`tfsec`](https://github.com/aquasecurity/tfsec-action?tab=readme-ov-file) for static analysis security scanning.
  2. Run [`Microsoft Defender for Cloud`](https://learn.microsoft.com/en-us/azure/defender-for-cloud/github-action) checks.

### 4. **Apply**
- **Purpose:** Applies the Terraform plan to the specified environment.
- **Triggers:** Only runs on the `main` or `release/` branches to control production deployments.
- **Job:**
  - Runs Terraform's `apply` command to make infrastructure changes based on the generated plan.
- **Steps:**
  1. Download the Terraform plan artifact.
  2. Install Terraform.
  3. Initialize the Terraform environment.
  4. Run the `terraform apply` command to deploy or modify the infrastructure.

[^ table of contents ^](#table-of-contents)

## Usage

1. **Define a trigger file** in your repository to initiate the Terraform CI/CD Orchestration workflow.
2. **Customize the inputs** according to your environment and Terraform setup.
3. **Push changes** to your repository or manually dispatch the workflow to run the Terraform processes.

This setup ensures a robust and controlled CI/CD pipeline for your Terraform projects, maintaining best practices and security standards.

