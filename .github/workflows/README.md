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

This workflow can be triggered through various events, such as a push to specific branches or a manual dispatch. Below is an example trigger file with matrix strategy for multiple environments:

```yaml
# .github/workflows/trigger.yml
name: Trigger Terraform Orchestration

on:
  push:
    branches:
      - main
      - release/*
  workflow_dispatch:

permissions:
  contents: read
  id-token: write
  actions: read
  security-events: write

jobs:
  terraform:
    name: Terraform CI/CD - ${{ matrix.name }}
    concurrency:
      group: terraform-${{ matrix.name }}-${{ github.ref }}
      cancel-in-progress: false
    strategy:
      fail-fast: false
      matrix:
        include:
          - name: dev
            backend_azure_rm_container_name: 'ops-terraform-state'
            backend_azure_rm_key: 'myapp.dev.tfstate'
            var_file: '../environments/dev.tfvars'
            command_option_args: ''
          - name: prod
            backend_azure_rm_container_name: 'ops-terraform-state'
            backend_azure_rm_key: 'myapp.prod.tfstate'
            var_file: '../environments/prod.tfvars'
            command_option_args: ''
    uses: casa-de-vops/terraform-code-standards/.github/workflows/azure-template.yml@main
    secrets: inherit
    with:
      tf_version: 'latest'
      working_directory: 'terraform/'
      gh_environment: ${{ matrix.name }}
      backend_azure_rm_resource_group_name: 'rg-terraform-ops'
      backend_azure_rm_storage_account_name: 'mystorageaccount'
      backend_azure_rm_container_name: ${{ matrix.backend_azure_rm_container_name }}
      backend_azure_rm_key: ${{ matrix.backend_azure_rm_key }}
      plan_file_name: 'terraform.tfplan'
      var_file: ${{ matrix.var_file }}
      command_option_args: ${{ matrix.command_option_args }}
```

## Inputs Description

The workflow can be customized using the following inputs:

| Name                                   | Description                                                                                          | Type     | Default Value       | Required |
|----------------------------------------|------------------------------------------------------------------------------------------------------|----------|---------------------|----------|
| `tf_version`                           | Specifies the Terraform version to use.                                                              | `string` | `'latest'`          | no       |
| `working_directory`                    | The directory where Terraform commands will be executed.                                             | `string` | n/a                 | yes      |
| `gh_environment`                       | The GitHub environment name, used for environment-specific variables, secrets, and artifact naming. | `string` | n/a                 | yes      |
| `backend_azure_rm_resource_group_name` | Azure Resource Group for Terraform state storage.                                                    | `string` | n/a                 | yes      |
| `backend_azure_rm_storage_account_name`| Azure Storage Account name where Terraform state is stored.                                          | `string` | n/a                 | yes      |
| `backend_azure_rm_container_name`      | Azure Storage container for the state file.                                                          | `string` | n/a                 | yes      |
| `backend_azure_rm_key`                 | The key or path within the container for the state file.                                             | `string` | n/a                 | yes      |
| `plan_file_name`                       | The name of the Terraform plan file.                                                                 | `string` | `'terraform.tfplan'`| no       |
| `var_file`                             | Specifies a variables file to be used with Terraform commands.                                       | `string` | `''`                | no       |
| `command_option_args`                  | Additional Terraform command options (e.g., `-var key=value`).                                       | `string` | `''`                | no       |

## Prerequisites

1. **GitHub Permissions:**
   - Ensure the appropriate GitHub permissions are set in your trigger file:
     - `contents: read`
     - `id-token: write`
     - `actions: read`
     - `security-events: write` (if using advanced security features).

2. **Azure Authentication Setup:**
   - **GitHub Actions Environment:**
     - Create a GitHub Actions environment and define the required variables for authenticating with Azure. This ensures that sensitive information is securely stored and managed.

   - **Federated Credentials (Recommended):**
     - Use [Federated Credentials](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp#configure-a-federated-identity-credential-on-an-app) for secure, passwordless authentication. With federated credentials, store the following as **repository or environment variables** in your GitHub Actions environment:
       - `AZURE_CLIENT_ID`: The client ID of the Azure service principal.
       - `AZURE_TENANT_ID`: The tenant ID of your Azure Active Directory.
       - `AZURE_SUBSCRIPTION_ID`: The subscription ID where resources will be managed.
     
   - **Alternative Authentication Methods:**
     - If necessary, you can use other forms of authentication, such as secret-based authentication. For these methods, in addition to the variables above, also store the following as a **secret**:
       - `AZURE_CLIENT_SECRET`: The client secret of the Azure service principal.
     - These can be used with the [Azure Login GitHub Action](https://github.com/Azure/login#readme) to authenticate during your workflows.

3. **Terraform Installation:**
   - Terraform is automatically installed by the workflow using the specified version.

## Workflow Jobs

### 1. **Validate**
- **Purpose:** Validates the Terraform configuration to ensure there are no syntax errors.
- **Environment:** `validate-<gh_environment>`
- **Steps:**
  1. Checkout the repository.
  2. Azure login using OIDC federated credentials.
  3. Install Terraform (specified version).
  4. Initialize Terraform with Azure backend.
  5. Run `terraform fmt --check` and `terraform validate`.
  6. Run security inspection with Microsoft Security DevOps (Checkov, Trivy, Terrascan).

### 2. **Plan**
- **Purpose:** Creates a Terraform execution plan showing the changes that will be made.
- **Environment:** `plan-<gh_environment>`
- **Depends on:** Validate job must succeed.
- **Steps:**
  1. Checkout the repository.
  2. Azure login and Terraform initialization.
  3. Load environment-specific variables from `versions/modules.<gh_environment>.yml`.
  4. Run `terraform plan` and save the execution plan.
  5. Upload plan as artifact (named `terraform-plan-<gh_environment>`).
  6. Generate plan summary (with optional AI-powered analysis if LLM is configured).

### 3. **Apply**
- **Purpose:** Applies the Terraform plan to the specified environment.
- **Environment:** `<gh_environment>` (requires approval if configured).
- **Triggers:** Only runs on `main` or `release/*` branches when plan has changes.
- **Steps:**
  1. Checkout the repository.
  2. Azure login and Terraform initialization.
  3. Download the plan artifact.
  4. Run `terraform apply` with the saved plan.

## Composite Actions

The workflow uses reusable composite actions located in `.github/actions/azure/`:

| Action          | Description                                                                 |
|-----------------|-----------------------------------------------------------------------------|
| `init`          | Azure login, Terraform setup, and backend initialization with OIDC.        |
| `validate`      | Runs `terraform fmt --check` and `terraform validate`.                     |
| `inspect`       | Runs Microsoft Security DevOps (Checkov, Trivy, Terrascan) security scans. |
| `plan`          | Creates Terraform plan and uploads as artifact.                            |
| `plan-summary`  | Generates plan summary with optional AI-powered analysis.                  |
| `apply`         | Downloads plan artifact and applies Terraform changes.                     |

## Concurrency

The workflow uses job-level concurrency to ensure only one deployment runs per environment per branch:

```yaml
concurrency:
  group: terraform-${{ matrix.name }}-${{ github.ref }}
  cancel-in-progress: false
```

This prevents race conditions when multiple commits are pushed in quick succession.

[^ table of contents ^](#table-of-contents)

## Usage

1. **Define a trigger file** in your repository to initiate the Terraform CI/CD Orchestration workflow.
2. **Configure the matrix** with your environments (dev, stage, prod) and their specific settings.
3. **Set up GitHub environments** with the required variables (`AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`).
4. **Configure protection rules** on your environments to require approvals before apply.
5. **Push changes** to your repository or manually dispatch the workflow to run the Terraform processes.

This setup ensures a robust and controlled CI/CD pipeline for your Terraform projects, maintaining best practices and security standards.