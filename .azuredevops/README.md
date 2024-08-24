## Table of Contents

- [Overview](../README.md)
- [Workflow Overview](./README.md)
  - [Terraform CI/CD Workflow](./docs/DEPLOY.md)
  - [Terraform Force-Unlock Workflow](./docs/UNLOCK.md)

# Azure DevOps Workflows

The Azure DevOps Workflows section offers a comprehensive set of reusable and scalable templates designed to automate the Terraform workflow across multiple environments in Azure. These workflows ensure that your infrastructure is managed consistently and securely, following best practices for continuous integration and continuous deployment (CI/CD) in cloud environments.

This section includes documentation on the following key workflows:

## Available Workflows

| Workflow | Purpose | Features | Why Use This Workflow? | Documentation |
|----------|---------|----------|------------------------|----------------|
| **[Terraform CI/CD Workflow](./tests/pipeline.deploy.yaml)** | Automates the end-to-end process of validating, planning, inspecting (security scanning), and applying Terraform configurations. | - **Validation:** Ensures that Terraform configurations are syntactically correct and meet the required standards. <br> - **Planning:** Generates an execution plan to align your infrastructure with the desired state. <br> - **Security Scanning:** Leverages tools like `tfsec` and Microsoft's Defender for Cloud. <br> - **Deployment:** Applies Terraform configurations across different Azure environments. | Essential for teams automating cloud infrastructure management, ensuring consistency, reducing manual errors, and accelerating deployment times. | [Terraform Deployment CI/CD](./docs/DEPLOY.md) |
| **[Terraform Force-Unlock Workflow](./tests/pipeline.unlock.yaml)** | Provides a mechanism to safely unlock Terraform state files locked due to interrupted operations. | - **State Unlocking:** Automatically unlocks Terraform state files. <br> - **Validation:** Confirms the unlock process is successful and the state file is no longer marked as locked. <br> - **Environment Support:** Supports multiple environments for versatile usage. | Crucial when a Terraform operation is interrupted, ensuring the state can be safely unlocked, avoiding potential issues or delays. | [Terraform State Unlock Workflow](./docs/UNLOCK.md) |

## Additional Information

### Workflow Integration

- **Modular Design:** Both workflows are designed to be modular and can be integrated into existing CI/CD pipelines with minimal adjustments. This flexibility allows teams to adopt these workflows in a variety of deployment scenarios.

- **Extensibility:** The workflows are built with extensibility in mind. Additional stages or custom tasks can be added to tailor the pipeline to specific organizational needs or compliance requirements.

### Best Practices

- **Version Control:** Ensure that all Terraform configurations are stored in version control (e.g., GitHub, Azure Repos) and that changes are reviewed and approved via pull requests. This practice enhances collaboration and helps maintain a history of changes.

- **Environment-Specific Configurations:** Use environment-specific parameters to handle different environments (e.g., development, staging, production) within the same pipeline. This approach allows for consistent deployments while accommodating environment-specific requirements.

- **Security Considerations:** Regularly update the security tools integrated into the pipeline, such as `tfsec` or Defender for Cloud, to ensure that your infrastructure remains compliant with the latest security standards.

---

This documentation serves as a guide for understanding and modifying the pipeline. Adjustments can be made to parameters, stages, or environment configurations based on specific requirements.
