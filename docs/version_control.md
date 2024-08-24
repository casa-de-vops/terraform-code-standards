## Table of Contents

- [Overview](../README.md)
  - [Directory Structure](./directory_structure.md)
  - [Domain Specific Files](./domain_specific_files.md)
  - [Naming Conventions](./naming_conventions.md#naming-conventions)
  - [Resource and State Management](./resource_and_state_management.md)
  - [Modules](./module.md)
  - [Variables and Outputs](./variables_and_outputs.md)
  - [Version Control](./version_control.md)
  - [Documentation](./documentation.md)
  - [Testing and Validation](./testing_and_validation.md)

## Version Control

- Version all Terraform code using Git or another version control system. This includes tracking changes to the `versions` folder, where environment-specific module manifests are stored.
- Commit changes frequently and provide meaningful commit messages. When updating module versions, clearly document changes in the commit messages to maintain an audit trail of version changes across environments.
- The `versions` YAML files allow you to pin specific versions of modules in different environments, which can be crucial for ensuring that production environments use stable and tested versions while development environments may use newer, experimental versions.
- During the CI/CD pipeline execution, these module versions can be replaced or updated based on the environment-specific YAML manifest, ensuring that each environment uses the correct versions of modules as defined in its corresponding YAML file.

## **Versioning Specifications**
The *Organization* Terraform Module Registry will adopt a versioning numbering scheme that follows the guidelines of [Semantic Versioning](http://semver.org/).

In summary, this means a version number will be represented in the form `MAJOR`.`MINOR`.`PATCH`.

**The following meanings apply:**
>- Increasing only the patch number suggests that the release includes only bug fixes, and is intended to be functionally equivalent.
>- Increasing the minor number suggests that new features have been added but that existing functionality remains broadly compatible.
>- Increasing the major number indicates that significant breaking changes have been made, and thus extra care or attention is required during an upgrade. To allow practitioners sufficient time and opportunity to upgrade to the latest version of the provider, we recommend releasing major versions no more than once per year. Releasing major versions more frequently could present a barrier to adoption due to the effort required to upgrade.

## Semantic Versioning Examples and Change Log

The following [**document**](./versioning.md) provides detailed examples of semantic increments and examples of changelog notes that can be used to guide versioning decisions 

[^ back to top ^](#table-of-contents)