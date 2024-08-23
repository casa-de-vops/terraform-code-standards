## Table of Contents

- [Overview](../README.md)
- Coding Standards
  - [Directory Structure](./directory_structure.md)
  - [Domain Specific Files](./domain_specific_files.md)
  - [Naming Conventions](./naming_conventions.md#naming-conventions)
  - [Resource and State Management](./resource_and_state_management.md)
  - [Modules](./module.md)
  - [Variables and Outputs](./variables_and_outputs.md)
  - [Version Control](./version_control.md)
  - [Documentation](./documentation.md)
  - [Testing and Validation](./testing_and_validation.md)

## Documentation

- Document all modules, variables, and outputs using Markdown files or inline comments. Well-documented code is crucial for maintaining clarity and ensuring that the purpose and functionality of each module are easily understood.
- Use **`tfdocs`** (Terraform Docs) to automatically generate documentation for your Terraform modules. This tool extracts information about resources, variables, outputs, and more from your Terraform files and formats it into a Markdown file.
- Provide a `README.md` for each module explaining its purpose, inputs, and outputs. By using `tfdocs`, you can ensure that your documentation is consistent, up-to-date, and includes all necessary details about your Terraform modules.

[^ back to overview ^](#table-of-contents)