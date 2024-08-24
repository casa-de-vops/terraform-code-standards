## Table of Contents

- [Overview](../README.md)
- [Back to Version Control](./version_control.md)

## **Examples**
### **Example Major Number Increments**
Increasing the `MAJOR` number is intended to signify potentially breaking changes.

**Within Terraform provider development, some examples include:**
>- Removing a resource or data source
>- Removing an attribute (e.g. switching to `Removed` on an attribute or removing the attribute definition altogether)
>- Renaming a resource or data source
>- Renaming an attribute
>- Changing fundamental provider behaviors (e.g. authentication or configuration precedence)
>- Changing resource import ID format
>- Changing resource ID format
>- Changing attribute type where the new type is functionally incompatible (including but not limited to changing `TypeSet` to `TypeList` and `TypeList` to `TypeSet`)
>- Changing attribute format (e.g. changing a timestamp from epoch time to a string)
>- Changing attribute default value that is incompatible with previous Terraform states (e.g. `Default: "one"` to `Default: "two"`)
>- Adding an attribute default value that does not match the API default

### **Example Minor Number Increments**
`MINOR` increments are intended to signify the availability of new functionality or deprecations of existing functionality without breaking changes to the previous version.

**Within Terraform provider development, some examples include:**
>- Marking a resource or data source as deprecated
>- Marking an attribute as deprecated
>- Adding a new resource or data source
>- Aliasing an existing resource or data source
>- Implementing new attributes within the provider configuration or an existing resource or data source
>- Implementing new validation within an existing resource or data source
>- Changing attribute type where the new type is functionally compatible (e.g. `TypeInt` to `TypeFloat`)

### **Example Patch Number Increments**
Increasing the `PATCH` number is intended to signify mainly bug fixes and to be functionally equivalent with the previous version.

**Within Terraform provider development, some examples include:**
>- Fixing an interaction with the remote API or Terraform state drift detection (e.g. broken create, read, update, or delete functionality)
>- Fixing attributes to match behavior with resource code (e.g. removing `Optional` when an attribute can not be configured in the remote API)
>- Fixing attributes to match behavior with the remote API (e.g. changing `Required` to `Optional`, fixing validation)

## **Change Log**
The changelog should live in a top level file in the project, named CHANGELOG or CHANGELOG.md.

**Information in the changelog should broken down as follows:**
> - `BACKWARDS INCOMPATIBILITIES` or `BREAKING CHANGES`: This section documents in brief any incompatible changes and how to handle them. This should only be present in major version upgrades.
>- `NOTES`: Additional information for potentially unexpected upgrade behavior, upcoming deprecations, or to highlight very important crash fixes (e.g. due to upstream API changes)
>- `FEATURES`: These are major new improvements that deserve a special highlight, such as a new resource or data source.
>- `IMPROVEMENTS` or `ENHANCEMENTS`: Smaller features added to the project such as a new attribute for a resource.
>- `BUG FIXES`: Any bugs that were fixed.

```
## 1.0.0 (Unreleased)

BREAKING CHANGES:

* Resource `network_port` has been removed [GH-1]

FEATURES:

* **New Resource:** `cluster` [GH-43]

IMPROVEMENTS:

* resource/load_balancer: Add `ATTRIBUTE` argument (support X new functionality) [GH-12]
* resource/subnet: Now better [GH-22, GH-32]

## 0.2.0 (Month Day, Year)

FEATURES:

...
```
[^ table of contents ^](#table-of-contents)