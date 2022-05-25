# Subcommands

## Troubleshooting
Four potential types of issues that you could experience with Terraform: language, state, core, and provider errors:
- **language**: the HashiCorp Configuration Language (HCL) is the primary interface for Terraform. This you may encounter **syntax errors** in your configuration (print out the line # and an explanation).
- **state**: problems when perfoming a sync between with the existing resources.
- **core**: errors at this point may be a bug. This interprets your configuration, manages your state file, constructs the resource dependency graph, and communicates with provider plugins.
- **provider**: it handle authentication, API calls, and mapping resources to services.

## `terraform fmt`
It only parses HCL for interpolation erros or malformed resource definitions. It is used to rewrite Terraform configuration files to a **canonical format and style**. Be aware that between Terraform versions if may change the style, so always run `terraform fmt` when moving upgrading/downgrading.

Params:
- `-recursive`: also process files in subdirectories.
- `-diff`: display diffs of formatting changes.
- `-list=false`: don't list files containing formatting inconsistencies.
- `-write=false`: don`t overwrite the input files.
- `-check`: check if the input is formatted.

## `terraform taint`
It informs Terraform that a particular object has become **degraded** or **damaged**. This object will be marked as *tainted* in the Terraform state, and Terraform will propose to replace it in the next plan you create.

This command is deprecated (**Terraform v0.15.2+**), instead use the `-replace` option to generate a new plan, knowing how it will affect your infrastructure before you take any externally-visible action. If you only use the `terraform taint`, other users could create a new plan against your tainted object before you can review the effects.

## `terraform state`
Advanced state management. It doesn`t modify directly the **Terraform state**. It is a **nested subcommand**, it has further subcommands. 

Each time you modify the state, backup files are written. The output path can be controlled with the `-backup` option.

## [`terraform workspace`](https://www.terraform.io/language/state/workspaces)
Your **Terraform configuration** has an *associated backend* that defines how operations are executed and where persistent data such as the **Terraform state** are stored. The persistent data in the backend belongs to a workspace. You may have multiple named workspaces from a single configuration (backend).

Even if you don`t create a workspace whenever you work with Terraform, you will be using the *default* workspace.

Create new workspace:
```tf
terraform workspace new <WorkspaceName>
```

Switch to workspace:
```tf
terraform workspace select <WorkspaceName>
```

Inside your configuration files you can use the variable `{terraform.sequence}`. 

When to use mutiple workspaces:
- Using multiple environments (production, testing, development).
- Related to feature branches in Version Control.
- Wanting to separate the work from a large team (decomposition).
- Creates copies of a set of infrastrucutre to test something before modifying the main production infrastructure. 


## [`terraform import`](https://www.terraform.io/cli/commands/import)
Import existing resources into Terraform. You must provide the ID of the existing resource, you must check the provider's documentation to get the proper ID.


## `terraform validate`
After formatting your configuration, you can use this subcommand to check your configuration in the context of the providers expectations.



 The errors that you may found:
 - **cycle error**: mutual dependency between resources.