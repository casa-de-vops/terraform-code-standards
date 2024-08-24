## Table of Contents

- [Overview](../README.md)
- [Azure DevOps Workflows](../README.md#azure-devops-workflows)
  - [Workflow Overview](./README.md)
  - [Terraform CI/CD Workflow](./DEPLOY.md)
  - [Terraform Force-Unlock Workflow](./UNLOCK.md)

# Terraform CI/CD Unlock Pipeline for AzDo

This pipeline is designed to automate the unlocking process of Terraform state files across multiple environments in Azure. It is intended for scenarios where a Terraform state is locked due to a failed or interrupted operation, allowing the state to be safely unlocked and the infrastructure to continue being managed. The pipeline supports various environments and is parameterized to handle different workloads.

## Parameters

The unlock pipeline uses the following parameters:

| Name                       | Description                                                             | Type      | Default Value                                 | Required |
|----------------------------|-------------------------------------------------------------------------|-----------|-----------------------------------------------|----------|
| `workload`                 | The workload identifier for the Terraform operation.                    | `string`  | n/a                                           | yes      |
| `environments`             | An object containing environment-specific parameters.                   | `object`  | n/a                                           | yes      |
| `working_directory`        | The directory where Terraform configuration files are located.          | `string`  | `'terraform'`                                 | no       |
| `tf_version`               | The version of Terraform to use.                                         | `string`  | `'latest'`                                    | no       |
| `lock_id`                  | The ID of the lock to be removed from the Terraform state.               | `string`  | `'00000000-0000-0000-0000-000000000000'`      | yes      |

### Note

- **`lock_id`** is a runtime parameter and must be passed in when triggering the pipeline. This allows the user to specify the exact lock ID that needs to be removed from the Terraform state.

[^ back to top ^](#table-of-contents)

## Environment Configuration

Each environment specified in the `environments` parameter should contain the following keys:

| Name                                 | Description                                                                                     | Type       | Default Value | Required |
|--------------------------------------|-------------------------------------------------------------------------------------------------|------------|---------------|----------|
| `environment`                        | The name or identifier for the environment (e.g., `dev`, `prod`).                               | `string`   | n/a           | yes      |
| `azure_service_connection`           | The Azure service connection to use for managing the Terraform state.                           | `string`   | n/a           | yes      |
| `backend_service_connection`         | The service connection for the Terraform backend (optional).                                    | `string`   | n/a           | no       |
| `backend_azure_rm_resource_group_name`| The name of the resource group containing the Terraform state storage.                          | `string`   | n/a           | yes      |
| `backend_azure_rm_storage_account_name`| The name of the storage account where the Terraform state is stored.                            | `string`   | n/a           | yes      |
| `backend_azure_rm_container_name`    | The name of the container within the storage account that holds the Terraform state file.       | `string`   | n/a           | yes      |
| `backend_azure_rm_key`               | The key of the Terraform state file within the container.                                       | `string`   | n/a           | yes      |

[^ back to top ^](#table-of-contents)

## Prerequisites

1. **Service Connection:**
   - Ensure that a service connection is created in Azure DevOps. This service connection is required to authenticate and authorize the pipeline to interact with Azure resources and manage the Terraform state.

2. **Terraform State Configuration:**
   - The Terraform state should be properly configured and accessible through the specified `azure_service_connection` and `backend_service_connection`. Ensure that the state file names and paths are correctly defined.

3. **State Locking and Unlocking Permissions:**
   - Verify that the pipeline has sufficient permissions to lock and unlock Terraform state files in the specified Azure environments.

[^ back to top ^](#table-of-contents)

## Detailed Pipeline Stages

This section outlines each stage in the Terraform CI/CD unlock pipeline. Each stage plays a crucial role in ensuring the state is unlocked safely and that the environment is ready for further operations.

### 1. **Force-Unlock Stage**

The Force-Unlock Stage performs the unlocking of the Terraform state file, allowing other operations to proceed.

- **Stage Name:** `ForceUnlock${{ environment.environment }}`
- **Display Name:** `Force-Unlock [${{ parameters.workload }}-${{ environment.environment }}]`
- **Depends On:** None
- **Job:**
  - **Terraform Force-Unlock Job:** Executes the Terraform `force-unlock` command to safely unlock the specified state file.

- **Steps:**
  1. **Install Terraform:** Ensure Terraform is installed on the agent using the specified `tf_version`.
  2. **Run Force-Unlock Command:** Execute `terraform force-unlock` to unlock the state file identified by `lock_id`.
  3. **Validate Unlock:** Confirm that the state file has been successfully unlocked and is no longer marked as locked.

[^ back to top ^](#table-of-contents)

### Example Unlock Pipeline Template

For a complete example of how to set up and deploy this unlock pipeline, refer to the following template:

[Example Unlock Pipeline](./tests/pipeline.unlock.yaml)

This example provides a basic Terraform configuration to unlock state files. It can be set up from your Azure DevOps Pipeline service to test the workflow and ensure that the pipeline is correctly configured and functioning as expected in your environment.

[^ back to top ^](#table-of-contents)