### Version Control

- Version all Terraform code using Git or another version control system. This includes tracking changes to the `versions` folder, where environment-specific module manifests are stored.
- Commit changes frequently and provide meaningful commit messages. When updating module versions, clearly document changes in the commit messages to maintain an audit trail of version changes across environments.
- The `versions` YAML files allow you to pin specific versions of modules in different environments, which can be crucial for ensuring that production environments use stable and tested versions while development environments may use newer, experimental versions.
- During the CI/CD pipeline execution, these module versions can be replaced or updated based on the environment-specific YAML manifest, ensuring that each environment uses the correct versions of modules as defined in its corresponding YAML file.

[^ back to overview ^](../README.md)