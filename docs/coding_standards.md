## Coding Standards
- [Overview](../README.md)
- [Coding Standards](#coding-standards)
  - [Directory Structure](#directory-structure)
  - [Domain Specific Files](#domain-specific-files)
  - [Resource and State Management](#resource-and-state-management)
  - [Modules](#modules)
  - [Variables and Outputs](#variables-and-outputs)
  - [Version Control](#version-control)
  - [Documentation](#documentation)
  - [Testing and Validation](#testing-and-validation)

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

[^ back to top ^](#coding-standards)

### Domain Specific Files

- Organize Terraform files based on specific domains within your infrastructure, such as networking, compute, and security, or align them with specific solutions like Key Vault, AKS, or App Services. This approach ensures that related configurations are grouped together, making it easier to manage, troubleshoot, and scale individual components or solutions.
- Utilize a structured directory layout that reflects the separation of concerns or solution alignment, ensuring that each domain or solution's files are logically grouped. This organization enhances maintainability and provides clarity when navigating the codebase, especially in complex enterprise environments.
- If you have locals that are global and your code is split across domain based files then you SHOULD put those locals within a locals.tf file. Otherwise, locals blocks SHOULD be declared at the top of your domain-name.tf or if a locals block is transforming a specific piece of data and only used a single time it SHOULD be directly above the Resource that is doing the transformation for.

[^ back to top ^](#coding-standards)

- Example structure:
  ```
    ├── workflows
    ├── versions
    ├── modules
    │   ├── keyvault
    |   │   ├── main.tf
    |   │   ├── variables.tf
    |   │   └── outputs.tf
    │   ├── aks
    |   │   ├── main.tf
    |   │   ├── variables.tf
    |   │   └── outputs.tf
    │   └── network
    |       ├── main.tf
    |       ├── variables.tf
    |       └── outputs.tf
    └── terraform
        ├── locals.tf
        ├── backend.tf
        ├── providers.tf
        ├── versions.tf
        ├── variables.tf
        ├── outputs.tf
        ├── keyvault.tf
        ├── aks.tf
        ├── network.tf    
        └── main.tf
  ```

[^ back to top ^](#coding-standards)


### Resource and State Management

- **Define *resource module* within your organization** as the most atomic definition of a single Azure Resource or tightly coupled resources. A resource module encapsulates the creation, management, and configuration of a specific Azure resource, such as a virtual network, storage account, or SQL database. These modules are reusable and serve as building blocks for more complex infrastructure deployments.

- **Define *pattern modules* within your organization** as an orchestration of related Azure resources, adding a layer on top of resource modules that specializes in the resource's governance and defines defaults that align with a use-case specification. Pattern modules are designed to encapsulate common architectural patterns, such as a multi-tier application architecture, integrating various resource modules to meet specific business requirements.

- **Utilize a hierarchical levels approach for state file management** in your Terraform projects, especially in complex enterprise environments. This approach helps manage the complexity of infrastructure, enhances security, and facilitates team autonomy by isolating different concerns into separate state files. The levels model, as recommended by Azure Terraform SRE landing zones, categorizes state files into levels based on different lifecycles, privileges, and organizational needs, see the [Azure Terraform SRE Landing zones for Terraform levels hierarchy overview](https://github.com/aztfmod/documentation/blob/main/website/docs/fundamentals/intro.md).

- **Control the blast radius and enforce the least privilege principle** by segregating state files based on their levels. Each level is protected by its own identity, and access controls are strictly enforced through Azure RBAC. This minimizes the risk of widespread disruption and enhances the security of the overall environment.

- **Enable autonomy and innovation within teams** by providing read-only access to lower-level state files and write access only to the current level. This allows teams to build on existing infrastructure components without risking unauthorized changes to more privileged resources.

- **Implement codeless state reading and enterprise composition** using tools like Azure Terraform SRE, which provide object models to load and compose landing zones in memory. This enables sophisticated environment composition and management while maintaining strict access controls.

- Store state files in a remote backend with appropriate access controls.
  
- Enable state locking to prevent concurrent modifications.
  
By defining clear resource and pattern modules, and adopting a structured levels hierarchy for state management, your organization can manage complex Azure environments more effectively, enhance security, and enable team autonomy.

[^ back to top ^](#coding-standards)

### Modules

- **Write reusable modules with clear input and output definitions** to ensure that your Terraform configurations are modular, maintainable, and easy to understand. Reusable modules help in standardizing infrastructure deployments across different projects and environments.

- **Leverage the Terraform Azure Verified Modules (AVM) Library** for pre-built, tested, and verified modules specifically designed for Azure infrastructure. These modules are curated by Microsoft and its partners, ensuring they adhere to best practices and are optimized for Azure. Using these verified modules can save time, reduce errors, and ensure that your deployments are aligned with Azure's best practices.

- **Store modules in a centralized location,** such as a version-controlled repository like GitHub, Azure Repos, or an internal registry. This allows teams to share and reuse modules across different projects, promoting consistency and reducing duplication of effort. For instance, you can manage custom modules and Azure Verified Modules together, making it easier to maintain and update them.

- **Version your modules appropriately** to ensure that changes can be tracked and managed effectively. By versioning your modules, you can control when and how updates are applied across different environments. This is particularly important when using modules from the AVM Library, as you may need to pin specific versions to ensure compatibility with your infrastructure.

- **Customize and Extend AVM Modules** by passing specific values to input variables or by composing multiple modules together to fit your specific use cases. The flexibility of Terraform combined with the reliability of AVM modules provides a powerful way to manage complex Azure environments.

By following these practices and leveraging the Azure Verified Modules Library, you can ensure that your Terraform modules are robust, reusable, and aligned with industry standards, helping to simplify the management of your Azure infrastructure.

[^ back to top ^](#coding-standards)

### Variables and Outputs
- **Use descriptive names for variables** to ensure clarity and maintainability. Each variable name should clearly indicate its purpose and the resource it is associated with. For example, instead of naming a variable `name`, use a more descriptive name like `vnet_name` or `storage_account_name` to reflect the specific resource the variable pertains to. This practice helps avoid confusion, especially in complex configurations with multiple resources.
- **Provide default values where appropriate** to simplify the usage of modules and to establish sensible defaults that align with your organization's standards. Default values can reduce the complexity for users by minimizing the number of required inputs, particularly for commonly used settings. For instance, setting a default region like `eastus` or a default VM size can streamline the deployment process.
- **Group related variables together** in your Terraform modules to improve readability and organization. For example, group networking-related variables (e.g., `subnet_id`, `vnet_id`, `network_security_group`) together. This makes the module easier to understand and use, as all related configurations are presented together.
- **Document each variable** using the `description` field to provide context and usage guidelines. This is particularly important in reusable modules where the end user might not be familiar with the internal details of the module. Clear documentation helps users understand the purpose of each variable and how it should be used, reducing the likelihood of misconfiguration.

  ```hcl
  variable "vnet_name" {
    description = "The name of the Virtual Network"
    type        = string
    default     = "my-vnet"
  }

[^ back to top ^](#coding-standards)

### Version Control

- Version all Terraform code using Git or another version control system. This includes tracking changes to the `versions` folder, where environment-specific module manifests are stored.
- Commit changes frequently and provide meaningful commit messages. When updating module versions, clearly document changes in the commit messages to maintain an audit trail of version changes across environments.
- The `versions` YAML files allow you to pin specific versions of modules in different environments, which can be crucial for ensuring that production environments use stable and tested versions while development environments may use newer, experimental versions.
- During the CI/CD pipeline execution, these module versions can be replaced or updated based on the environment-specific YAML manifest, ensuring that each environment uses the correct versions of modules as defined in its corresponding YAML file.

[^ back to top ^](#coding-standards)

### Documentation

- Document all modules, variables, and outputs using Markdown files or inline comments. Well-documented code is crucial for maintaining clarity and ensuring that the purpose and functionality of each module are easily understood.
- Use **`tfdocs`** (Terraform Docs) to automatically generate documentation for your Terraform modules. This tool extracts information about resources, variables, outputs, and more from your Terraform files and formats it into a Markdown file.
- Provide a `README.md` for each module explaining its purpose, inputs, and outputs. By using `tfdocs`, you can ensure that your documentation is consistent, up-to-date, and includes all necessary details about your Terraform modules.

[^ back to top ^](#coding-standards)

### Testing and Validation

- Avoid hardcoding sensitive data in Terraform configurations.
- Use `terraform validate` and `terraform fmt` to check for syntax and style issues.
- Incorporate **`tfsec`** into your workflow to perform static analysis and security scanning on your Terraform code. `tfsec` scans your code for potential security vulnerabilities and best practice violations, providing contextual information to help you understand and fix issues.
- Integrate **`tfsec`** into your CI/CD pipeline to automate security checks as part of your deployment process. This helps ensure that your Terraform code is secure and compliant before it reaches production.
- Use **`tfdocs`** to ensure that your modules are well-documented, which is crucial for ongoing testing, validation, and maintenance efforts.
- Incorporate automated testing where possible to ensure reliability. Automated tests can help identify issues early in the development process, reducing the risk of deploying insecure or faulty infrastructure.
- Consider using additional tools to enhance security and compliance across your infrastructure-as-code (IaC) projects:
  - **Checkov:** Scans Terraform, CloudFormation, Kubernetes, and more for security misconfigurations.
  - **Terrascan:** Focuses on scanning Terraform, Kubernetes, Helm, and other IaC formats for compliance and security issues.
  - **IaCFileScanner:** A template mapping tool for Terraform, CloudFormation, ARM Templates, and Bicep.
  - **Template Analyzer:** Scans ARM Templates and Bicep files for security and best practices.
  - **Trivy:** Scans container images and IaC for vulnerabilities and misconfigurations.
  
- These tools, along with **Bandit** for Python, **BinSkim** for binaries, and **ESLint** for JavaScript, provide comprehensive coverage for various aspects of code security and compliance. They can be integrated into your CI/CD pipelines to automate testing and validation processes.
  
- For more details on integrating these tools into your Azure DevOps workflows, refer to the [Microsoft documentation](https://learn.microsoft.com/en-us/azure/defender-for-cloud/azure-devops-extension).

[^ back to top ^](#coding-standards)