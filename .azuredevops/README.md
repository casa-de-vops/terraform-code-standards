## Table of Contents

- [Overview](../README.md)
- [Azure DevOps Workflows](../README.md#azure-devops-workflows)
  - [Workflow Overview](./README.md)
  - [Terraform CI/CD Workflow](./DEPLOY.md)
  - [Terraform Force-Unlock Workflow](./UNLOCK.md)

# Terraform Pipeline Documentation

This pipeline is designed to automate the validation, planning, inspection (security scanning), and application of Terraform configurations for multiple environments in Azure. The pipeline is parameterized to support various environments, workloads, and Terraform configurations.

## Terraform CI/CD Workflow for AzDo

You can find a full documentation and examples of the pipeline configuration at the following link:

[Terraform Deployment CI/CD](./DEPLOY.md)

## Terraform State Unlock Workflow for AzDo

You can find a full documentation and examples of the pipeline configuration at the following link:

[Terraform State Unlock Workflow](./UNLOCK.md)

---

This documentation serves as a guide for understanding and modifying the pipeline. Adjustments can be made to parameters, stages, or environment configurations based on specific requirements.
