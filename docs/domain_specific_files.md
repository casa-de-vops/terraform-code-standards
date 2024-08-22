### Domain Specific Files

- Organize Terraform files based on specific domains within your infrastructure, such as networking, compute, and security, or align them with specific solutions like Key Vault, AKS, or App Services. This approach ensures that related configurations are grouped together, making it easier to manage, troubleshoot, and scale individual components or solutions.
- Utilize a structured directory layout that reflects the separation of concerns or solution alignment, ensuring that each domain or solution's files are logically grouped. This organization enhances maintainability and provides clarity when navigating the codebase, especially in complex enterprise environments.
- If you have locals that are global and your code is split across domain based files then you SHOULD put those locals within a locals.tf file. Otherwise, locals blocks SHOULD be declared at the top of your domain-name.tf or if a locals block is transforming a specific piece of data and only used a single time it SHOULD be directly above the Resource that is doing the transformation for.

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

[^ back to overview ^](../README.md)