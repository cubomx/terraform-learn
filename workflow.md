# Workflow
[`terraform init`](https://www.terraform.io/cli/commands/init):
- it is the first command that should be run
- it is safe to run it multiple times
- it brings the working directory to the most recent changes in your configuration

    params:
    - `input=true`: ask for input
    - `lock=false`: disable locking of state files during performing operations against them
    - `lock-timeout=<duration>`: this is the time that Terraform will wait to acquire a state lock
    - `-no-color`: disable color in output
    - `upgrade`

[`terraform validate`](terraform.io/cli/commands/validate): it verifies it a configuration is syntactically valid and internally consistent. It doesn't check any remote services (remote state, provider APIs).
- general verification of reusable modules
    - correctness of attribute names & value types

    params:
    - `json`: output in JSON format 
    - `no-color`: output won't contain any color


output:
- valid
- error_count
- warning_count
- diagnostics: describes each error (array).
    For each error, an object:
    - severity: **error**, **warning**
    - summary: short description
    - detail: optional message, more detail about the problem


[`terraform plan`](https://www.terraform.io/cli/commands/plan): creates an execution plan, it previews the changes that Terraform plans to make to your infrastructure. If not changes needed Terraform will report that not actions need to be taken.

params:
- `out=<File>`: to save the generated plant to a file on disk.

Planning modes:
- **Destroy mode**: creates a plan whose goal is to destory all remote objects that curretly exist. Activate it with the `-destroy` cmd option.
- **Refresh-only mode**: creats a plan to reconcile the changes made to remote objects outside of Terraform. Use the `-refresh-only` option.

[`terraform apply`](https://www.terraform.io/cli/commands/apply): it executes the actions proposed in a Terraform plan.

If run without a saved plan file, **terraform apply** supports all of **terraform plan**'s planning modes and planning options.

params:
- `-auto-approve`: skips prompt for confirmation.
- `-compact-warnings`: it compacts all the warning messages.
- `-input=false`: disables all of Terraform's interactive prompts.
- `-json`: output in JSON.
- `-lock=false`: don't hold a state lock during the operation.
- `-lock-timeout<n>`
- `-no-color`
- `-parallelism=n`

`terraform show`: to inspect a plan file before applying it.

[`terraform destroy`](https://www.terraform.io/cli/commands/destroy): is a convenient way to destroy all remote objects managed by a particular Terraform configuration.