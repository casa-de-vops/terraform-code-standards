# Terraform Azure DevOps Pipeline

This repository contains an Azure DevOps pipeline for deploying Terraform configurations across multiple environments.

## Pipeline Overview

The pipeline is structured into three main stages:

1. **Validate**: 
   - Validates the Terraform configuration.
   - Ensures syntax and structure are correct.

2. **Inspect**: 
   - Generates code coverage report.
   - Generates tfsec security report.

2. **Plan**: 
   - Generates an execution plan.
   - Displays changes that will be made to the infrastructure.

3. **Apply**: 
   - Applies the changes described in the plan.
   - Deploys or updates resources in Azure.

## Pipeline Parameters

- **workload**: Name of the workload.
- **environments**: List of environments to deploy (e.g., dev, staging, production).
- **working_directory**: Directory containing Terraform files (default: `terraform`).
- **tf_version**: Terraform version to use (default: `latest`).
- **securevars_file**: File containing secure variables (default: `null`).
- **install_ssh**: Boolean to install SSH keys (default: `true`).
- **plan_file_name**: Name of the plan file (default: `terraform.tfplan`).

## Pipeline Flow

1. **Validate Stage**: 
   - Executes for each environment.
   - Runs validation on the Terraform configuration.

2. **Plan Stage**: 
   - Depends on the Validate stage.
   - Runs a `terraform plan` and generates a plan file for review.

3. **Apply Stage**: 
   - Depends on both Validate and Plan stages.
   - Applies the Terraform plan to create or modify infrastructure.

## Pool & VM Image Handling

- **Agent Pool**: If provided, the pipeline uses the specified agent pool.
- **VM Image**: If no agent pool is provided:
  - Defaults to `Ubuntu-20.04` if no image is specified.
  - Uses the provided VM image if specified.

## Required Azure DevOps Extensions

- **Terraform CLI Tasks**: Required to execute Terraform commands (`init`, `plan`, `apply`, etc.). [Get Terraform CLI task](https://marketplace.visualstudio.com/items?itemName=JasonBJohnson.azure-pipelines-tasks-terraform)
- **Token Replacement Tasks**: Needed to replace tokens within the Terraform configuration files. [Get Replace Token task](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens&targetId=630e9553-f888-491d-b723-4e77b2b0602a&utm_source=vstsproduct&utm_medium=ExtHubManageList)

## Usage

To use this pipeline, configure the required parameters in your Azure DevOps pipeline configuration. Adjust the environment settings and Terraform files as needed for your project.
