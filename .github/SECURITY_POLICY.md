# Security Policy

## Reporting Security Vulnerabilities

The terraform-code-standards project takes security seriously. We appreciate your efforts to responsibly disclose your findings.

### How to Report a Security Vulnerability

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report them via one of the following methods:

1. **GitHub Security Advisories** (Preferred)
   - Navigate to the repository's Security tab
   - Click "Report a vulnerability"
   - Fill out the advisory form with details

2. **Private Disclosure**
   - Contact the repository maintainers directly
   - Include detailed information about the vulnerability
   - Allow reasonable time for remediation before public disclosure

### What to Include in Your Report

To help us triage and respond to your report quickly, please include:

- **Type of vulnerability** (e.g., authentication bypass, injection, etc.)
- **Full paths of affected source files**
- **Location of the affected code** (tag/branch/commit or direct URL)
- **Step-by-step instructions to reproduce the issue**
- **Proof-of-concept or exploit code** (if possible)
- **Impact of the vulnerability** (what an attacker could achieve)
- **Suggested remediation** (if you have recommendations)

### Our Commitment

When you report a vulnerability, we commit to:

- **Acknowledge receipt** within 48 hours
- **Provide an initial assessment** within 5 business days
- **Keep you informed** about our progress
- **Credit your discovery** in release notes (if desired)

### Security Response Timeline

- **Critical vulnerabilities**: Patches within 7 days
- **High vulnerabilities**: Patches within 30 days
- **Medium vulnerabilities**: Patches within 90 days
- **Low vulnerabilities**: Addressed in regular release cycle

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | ✅ Yes             |
| Main    | ✅ Yes             |
| Older   | ❌ No              |

We recommend always using the latest version to benefit from security patches.

## Security Best Practices for Users

When using this repository and its workflows:

### 1. Authentication & Credentials
- ✅ **DO** use OIDC/federated credentials for Azure authentication
- ✅ **DO** store secrets in Azure Key Vault or GitHub Secrets
- ✅ **DO** rotate credentials regularly
- ❌ **DON'T** commit credentials to version control
- ❌ **DON'T** use long-lived access tokens

### 2. GitHub Actions Security
- ✅ **DO** review workflow permissions before use
- ✅ **DO** use environment protection rules for sensitive deployments
- ✅ **DO** limit workflow permissions to minimum required
- ❌ **DON'T** use `pull_request_target` without careful review
- ❌ **DON'T** disable security scanning workflows

### 3. Terraform Security
- ✅ **DO** enable state encryption
- ✅ **DO** use remote state with access controls
- ✅ **DO** run security scanning tools (Checkov, Trivy, Terrascan)
- ✅ **DO** review plan output before applying
- ❌ **DON'T** commit state files or plan files
- ❌ **DON'T** disable backend authentication

### 4. Dependencies & Supply Chain
- ✅ **DO** pin action versions
- ✅ **DO** review changes to dependencies
- ✅ **DO** enable Dependabot alerts
- ❌ **DON'T** use untrusted third-party actions
- ❌ **DON'T** ignore security advisories

## Automated Security Scanning

This repository includes automated security scanning via:

### Security Tools Integrated
1. **Checkov** - Policy-as-code scanner for IaC
2. **Trivy** - Comprehensive vulnerability scanner
3. **Terrascan** - Terraform security scanner
4. **Microsoft Security DevOps** - Multi-tool security suite

### Scan Frequency
- ✅ On every pull request
- ✅ On push to main branch
- ✅ Weekly scheduled scans (Saturdays at 16:23 UTC)
- ✅ Manual dispatch available

### Security Alerts
Security findings are reported to:
- GitHub Security tab (Advanced Security)
- Pull Request summaries
- Workflow artifacts

## Known Security Considerations

### Current Implementation

1. **OIDC Authentication** ✅
   - Implemented for Azure authentication
   - Federated credentials recommended
   - No long-lived secrets required

2. **Secret Management** ✅
   - Azure Key Vault integration
   - GitHub Secrets for CI/CD
   - Proper secret masking in logs

3. **Access Control** ✅
   - Least privilege permissions
   - Environment-based approvals
   - Granular GitHub Actions permissions

4. **Supply Chain Security** 🟡
   - Using semantic versioning for actions
   - Could be enhanced with commit SHA pinning
   - Dependabot recommended for updates

## Security Hardening Checklist

Before deploying to production, ensure:

- [ ] OIDC authentication configured for Azure
- [ ] GitHub environments set up with protection rules
- [ ] Secrets stored in Azure Key Vault or GitHub Secrets
- [ ] Branch protection enabled on main/release branches
- [ ] Security scanning workflows enabled
- [ ] Dependabot alerts enabled
- [ ] Required reviewers configured
- [ ] No hardcoded credentials in code
- [ ] State file encryption enabled
- [ ] Service principal follows least privilege

## Incident Response

In the event of a security incident:

1. **Contain**: Immediately revoke compromised credentials
2. **Assess**: Determine scope and impact
3. **Remediate**: Apply patches and mitigations
4. **Notify**: Inform affected users (if applicable)
5. **Learn**: Document lessons learned and improve processes

## Compliance & Standards

This repository follows security guidelines from:

- OWASP Top 10
- CIS Benchmarks for Cloud Infrastructure
- Microsoft Security Best Practices
- GitHub Actions Security Hardening Guide
- Terraform Security Best Practices

## Security Contact

For security-related questions that are not vulnerabilities:
- Open a GitHub Discussion
- Tag with `security` label
- Refer to documentation in `/docs` folder

## Attribution

We appreciate the security research community and will acknowledge all valid vulnerability reports (unless you prefer to remain anonymous).

## License

This security policy is licensed under the same terms as the main project (Apache 2.0).

---

**Last Updated:** 2026-01-29  
**Policy Version:** 1.0
