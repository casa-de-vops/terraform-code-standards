## Table of Contents

- [Overview](../../README.md)
- [Workflow Overview](../README.md)
  - [Terraform CI/CD Workflow](./DEPLOY.md)
  - [Terraform Force-Unlock Workflow](./UNLOCK.md)

## Terraform CI/CD Pipeline for AzDo

This pipeline is designed to automate the validation, planning, inspection (security scanning), and application of Terraform configurations for multiple environments in Azure. The pipeline is parameterized to support various environments, workloads, and Terraform configurations.

The deployment workflow manages the deployment of Azure resources using Azure DevOps Pipelines and Terraform. It is triggered by changes in specific branches and paths, ensuring that the infrastructure is updated automatically.

## Parameters

The deployment pipeline uses the following parameters:

| Name                     | Description                                                          | Type          | Default Value                              | Required |
|--------------------------|----------------------------------------------------------------------|---------------|--------------------------------------------|----------|
| `workload`               | The workload identifier for the Terraform operation.                 | `string`      | n/a                                        | yes      |
| `environments`           | An object containing environment-specific parameters.                | `object`      | n/a                                        | yes      |
| `working_directory`      | The directory where Terraform configuration files are located.       | `string`      | `'terraform'`                              | no       |
| `tf_version`             | The version of Terraform to use.                                     | `string`      | `'latest'`                                 | no       |
| `securevars_file`        | The path to a secure variables file.                                 | `string`      | `''`                                       | no       |
| `plan_file_name`         | The name of the Terraform plan file. 

[^ table of contents ^](#table-of-contents)

## Environment Configuration

Each environment specified in the `environments` parameter should contain the following keys:

| Name                        | Description                                                                                     | Type       | Default Value | Required |
|-----------------------------|-------------------------------------------------------------------------------------------------|------------|---------------|----------|
| `pool`               | The name or identifier for the agent pool (e.g., `Azure Pipelines`, `Default`).                               | `string`   | n/a           | no      |
| `vmImage`               | The name or identifier for the vm-image to use for the agent pool (e.g., `ubuntu-latest`).                               | `string`   | n/a           | no      |
| `environment`               | The name or identifier for the environment (e.g., `dev`, `prod`).                               | `string`   | n/a           | yes      |
| `azure_service_connection`  | The Azure service connection to use for deploying resources.                                    | `string`   | n/a           | yes      |
| `tfvars_file`               | Path to the Terraform variables file specific to the environment.                               | `string`   | n/a           | yes      |
| `backend_service_connection`| The service connection for the Terraform backend (optional).                                    | `string`   | n/a           | no       |
| `backend_azure_rm_*`        | Details for the Azure RM backend configuration (resource group name, storage account name, container name, key). | `string` | n/a           | yes      |
| `destroy_mode`              | If true, the pipeline will run in destroy mode.                                                 | `boolean`  | `false`       | no       |
| `command_option_args`       | Additional command options for the Terraform plan or apply command.                             | `string`   | `''`          | no       |

[^ table of contents ^](#table-of-contents)

## Prerequisites

1. **Service Connection:**
   - Ensure that a service connection is created in Azure DevOps. This service connection is required to authenticate and authorize the pipeline to interact with Azure resources.

2. **SSH Configuration (Optional):**
   - If your Terraform modules or templates are sourced from a Git repository that requires SSH authentication, additional setup is required:
     - **Upload SSH Key:** Upload your device's `ssh_key` as a secure variable in the variable library.
     - **Create Azure DevOps Library Variable Group:**
       - Create a variable group (e.g., `ssh_host`) containing the following variables:
         - `knownHostsEntry`: The SSH known hosts entry for the source control.
         - `sshPublicKey`: The public SSH key used for authentication.
         - `sshPassphrase`: The passphrase for the SSH key, if any.
         - `sshKeySecureFile`: The secure file that contains the private SSH key.
     - **Configure Pipeline:**
       - Configure this variable group in the pipeline to ensure the agent has the necessary SSH credentials.
     - **Optional Configuration:**
       - If the modules are public or local, set the `install_ssh` parameter to **false** in the [variables](../.azuredevops/variables/) files for your environment.

3. **Backend Service Connection:**
   - A separate service connection should be used for managing the backend layer of the Terraform environment.
   - **Default Behavior:** If the `backend_service_connection` parameter is not specified in the pipeline, the `azure_service_connection` parameter will be used by default.

[^ table of contents ^](#table-of-contents)

## Detailed Pipeline Stages

This section outlines each stage in the Terraform CI/CD pipeline. Each stage has a specific role in validating, planning, inspecting, and applying Terraform configurations.

### 1. **Validation Stage**

The Validation Stage runs Terraform's `validate` command to ensure the syntax and configuration of the Terraform files are correct for each environment.

- **Stage Name:** `ValidateStage${{ environment.environment }}`
- **Job:**
  - **Terraform Validate Job:** Initializes the Terraform environment and runs the validation process.

- **Steps:**
  1. **Install Terraform:** Ensure Terraform is installed on the agent.
  2. **Token Replacement:** Replace tokens in the Terraform configuration files with the appropriate environment-specific values.
  3. **Initialize:** Initialize the Terraform environment to prepare it for validation.
  4. **Validate:** Run the `terraform validate` command to check the configuration for errors.

### 2. **Plan Stage**

The Plan Stage runs Terraform's `plan` command, which generates an execution plan. This plan outlines the actions Terraform will take to align the infrastructure with the desired state.

- **Stage Name:** `PlanStage${{ environment.environment }}`
- **Depends On:** The corresponding `ValidateStage` for the environment.
- **Job:**
  - **Terraform Plan Job:** Runs Terraform's planning process to create an execution plan.

- **Steps:**
  1. **Install Terraform:** Ensure Terraform is installed on the agent.
  2. **Token Replacement:** Replace tokens in the Terraform configuration files with the appropriate environment-specific values.
  3. **Initialize:** Initialize the Terraform environment to prepare it for planning.
  4. **Generate Plan:** Run the `terraform plan` command to generate the execution plan and save it as an artifact.

### 3. **Inspect Stage**

The Inspect Stage performs security scans on the Terraform configuration using tools like `tfsec` and Microsoft's Defender for Cloud.

- **Stage Name:** `InspectStage${{ environment.environment }}`
- **Depends On:**
  - `InspectStage`
  - `PlanStage`
- **Job:**
  - **Terraform Inspect Job:** Runs security tools to scan the Terraform configuration for vulnerabilities.

- **Steps:**
  1. **Run `tfsec`:** Perform static analysis security scanning on the Terraform files using `tfsec`.
  2. **Optional Security Checks:** Optionally, run Microsoft Defender for Cloud checks to assess security compliance.

    Configure these checks by setting the following variables in the [variables](./variables/) file:
    - `run_tfsec`: `true`
    - `security_tools`: `"iacfilescanner, trivy, terrascan"` *(comma-separated list of security tools to run by Azure Defender for DevOps)*

### 4. **Apply Stage**

The Apply Stage applies the Terraform configuration to each environment, making the necessary infrastructure changes based on the execution plan.

- **Stage Name:** `ApplyStage${{ environment.environment }}`
- **Depends On:**
  - `InspectStage`
  - `PlanStage`
  - `ValidateStage`
- **Condition:** This stage runs only if the Plan Stage indicates that changes are needed and if the source branch is `release` or `main`.
- **Job:**
  - **Terraform Apply Job:** Runs Terraform's `apply` command to make infrastructure changes based on the generated plan.

- **Steps:**
  1. **Download Plan Artifact:** Download the Terraform plan artifact generated in the Plan Stage.
  2. **Install Terraform:** Ensure Terraform is installed on the agent.
  3. **Initialize:** Initialize the Terraform environment to prepare it for applying changes.
  4. **Apply Plan:** Run the `terraform apply` command to deploy or modify the infrastructure as per the plan.

[^ table of contents ^](#table-of-contents)

### Example Pipeline Templates

For a complete example of how to set up and deploy this pipeline, refer to the following template:

[Example Deployment Pipeline](./tests/pipeline.deploy.yaml)

This example provides a basic Terraform configuration that does not deploy any resources. It can be setup from your Azure DevOps Pipeline service to test the workflow and ensure that the pipeline is correctly configured and functioning as expected in your environment.

[^ table of contents ^](#table-of-contents)

### Validating Pipeline Outputs

To ensure the pipeline is functioning correctly, you can validate the output of the test template run against the expected values set in various layers of your configuration.

#### Example Output:
After running the pipeline, you should see an output similar to this:

```hcl
validation = {
  + config_variable      = "default_value"
  + environment_variable = "environment_value_dev"
  + module_versions      = {
      + eh_keeper = "1.1.0"
      + kv_keeper = "1.1.0"
    }
  + pipeline_variable    = "command_option_nonprod"
}

### Steps to Validate:

1. **Validate Against Environment Variables:**
   - Check the `environment_variable` output:
     - Expected Value: `"environment_value_dev"`
     - Location: Defined in `.azuredevops/variables/`
     - Purpose: Ensures that the correct environment configuration is being used in the pipeline.

2. **Validate Pipeline Variables:**
   - Check the `pipeline_variable` output:
     - Expected Value: `"command_option_nonprod"`
     - Location: Passed in by the environment-specific `deploy.yml` file
     - Purpose: Verifies that the pipeline is applying the correct command options for the specified environment.

3. **Validate Configuration Variable:**
   - Check the `config_variable` output:
     - Expected Value: `"default_value"`
     - Location: Defined in your Terraform variables
     - Purpose: Confirms that the correct configuration is being applied within the pipeline.

4. **Validate Module Versions:**
   - Check the `module_versions` output:
     - Expected Values:
       - `eh_keeper`: `"1.1.0"`
       - `kv_keeper`: `"1.1.0"`
     - Location: Defined in `tests/versions/`
     - Purpose: Ensures that the correct module versions are being used during pipeline execution.

By following these steps, you can validate that each key aspect of your pipeline's configuration is functioning as expected across different environments and scenarios.

[^ table of contents ^](#table-of-contents)