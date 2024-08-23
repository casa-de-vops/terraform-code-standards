# Terraform Pipeline Documentation

This pipeline is designed to automate the validation, planning, inspection (security scanning), and application of Terraform configurations for multiple environments in Azure. The pipeline is parameterized to support various environments, workloads, and Terraform configurations.

## Pipeline Parameters

### Global Parameters

- **`workload`** (`string`): Name of the workload being deployed or managed by Terraform.
- **`environments`** (`object`): A collection of environments to be deployed. Each environment in this object should contain relevant details like `azure_service_connection`, `tfvars_file`, and any backend configuration.
- **`working_directory`** (`string`, default: `terraform`): The directory where Terraform configuration files are located.
- **`tf_version`** (`string`, default: `latest`): Version of Terraform to install and use during the pipeline run.
- **`securevars_file`** (`string`, default: `''`): A file containing sensitive variables to be used by Terraform. Optional.
- **`install_ssh`** (`boolean`, default: `true`): Determines whether SSH keys should be installed for the Terraform commands.
- **`plan_file_name`** (`string`, default: `terraform.tfplan`): The name of the Terraform plan file generated during the `Plan` stage.

## Pipeline Stages

### 1. Validation Stage

This stage runs Terraform's `validate` command for each environment. It ensures the syntax and configuration of Terraform files are correct.

- **Stage Name**: `ValidateStage${{ environment.environment }}`
- **Jobs**:
  - **Terraform Validate Job**: This job runs Terraform validation, initializing the Terraform environment first.

- **Steps**:
  1. Install Terraform.
  2. Replace tokens in the Terraform configuration files with appropriate values.
  3. Initialize the Terraform environment.
  4. Validate the Terraform configuration.

### 2. Plan Stage

This stage runs Terraform's `plan` command for each environment. It creates an execution plan, showing what actions Terraform will take to reach the desired state.

- **Stage Name**: `PlanStage${{environment.environment}}`
- **Depends On**: Corresponding `ValidateStage` for the environment.
- **Jobs**:
  - **Terraform Plan Job**: This job runs Terraform's planning process.

- **Steps**:
  1. Install Terraform.
  2. Replace tokens in the Terraform configuration files with appropriate values.
  3. Initialize the Terraform environment.
  4. Generate the Terraform plan file.

### 3. Security Scan Stage

This stage performs security scans on the Terraform configuration using tools like `tfsec` and Microsoft's Defender for Cloud.

- **Stage Name**: `InspectStage${{ environment.environment }}`
- **Depends On**: None (Can be configured to depend on the Plan stage).
- **Jobs**:
  - **Terraform Inspect Job**: Runs security tools to scan the Terraform configuration.

- **Steps**:
  1. Run `tfsec` for static analysis security scanning.
  2. Optionally run Microsoft Defender for Cloud security checks.

### 4. Apply Stage

This stage applies the Terraform configuration to each environment, making the necessary infrastructure changes.

- **Stage Name**: `ApplyStage${{environment.environment}}`
- **Depends On**:
  - `InspectStage`
  - `PlanStage`
  - `ValidateStage`

- **Condition**: Only runs if the plan stage indicates changes are needed and if the source branch is `release` or `main`.

- **Jobs**:
  - **Terraform Apply Job**: This job runs Terraform's `apply` command to make infrastructure changes.

- **Steps**:
  1. Download the Terraform plan artifact.
  2. Install Terraform.
  3. Initialize the Terraform environment.
  4. Apply the Terraform plan to deploy or modify infrastructure.

## Environment Configuration

Each environment specified in the `environments` parameter should contain the following keys:

- **`environment`** (`string`): The name or identifier for the environment (e.g., `dev`, `prod`).
- **`azure_service_connection`** (`string`): The Azure service connection to use for deploying resources.
- **`tfvars_file`** (`string`): Path to the Terraform variables file specific to the environment.
- **`backend_service_connection`** (`string`): The service connection for the Terraform backend (optional).
- **`backend_azure_rm_*`** (`string`): Details for the Azure RM backend configuration (resource group name, storage account name, container name, key).
- **`destroy_mode`** (`boolean`, optional): If true, the pipeline will run in destroy mode.
- **`command_option_args`** (`string`, optional): Additional command options for the Terraform plan or apply command.

## Sample Trigger Pipeline

A sample trigger pipeline can be set up in Azure DevOps to call these templates. You can find an example at the following link:

[Sample Trigger Pipeline](https://github.com/casa-de-vops/terraform-code-standards/blob/main/.azuredevops/tests/pipeline.yaml)

---

This documentation serves as a guide for understanding and modifying the pipeline. Adjustments can be made to parameters, stages, or environment configurations based on specific requirements.
