# Manage state

## [State locking](https://www.terraform.io/language/state/locking)
(**If supported by your backend**) Terraform will lock your state for all operationa that could modify the state. You can disable it with the `block` flag (*not recommended*).

You could **force unlock** to manually unlock the state if unlocking failed. **BE VERY CAREFUL**. To protect you, the `force-unlock` command requires a unique ID.

## [Sensitive Data in State](https://www.terraform.io/language/state/sensitive-data)
Terraform state can contain sensitive data (database passwords). Local state may stored in plain-text JSON files. 

### Recommendations
Store the state remotely to provide better security.
- **Terraform Cloud** encryptd state at rest & protects it with TLS in transit.
- S3 backend supports encryption.

## [`terraform refresh`](https://www.terraform.io/cli/commands/refresh)
Reads the current settings from all managed remote objects & updates the Terraform state to match. This won't modify your real remote objects, but it will modify the Terraform state.

Run instead `terraform plan -refresh-only` or `terraform apply -refresh-only`.

## [Backends](https://www.terraform.io/language/settings/backends)
This is where Terraform's state snapshots are stored:
- Specify a backend
- Integrate with Terraform Cloud
- Store [locally](https://www.terraform.io/language/settings/backends) 

Backends are [configured](https://www.terraform.io/language/settings/backends/configuration) with a nested `backend` block within the top-level `terraform` block: 
```tf
terraform {
  backend "remote" {
    organization = "example_corp"

    workspaces {
      name = "my-app-prod"
    }
  }
}
```

### Initialization
Any change to the configuration's backend changes must be followed by `terraform init` to validate and configure the backend before you can perfom any plans, applies, or state operations.

