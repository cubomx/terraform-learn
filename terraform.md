# Review

## Iac
- Versioned
- Shared
- Reusable
- Not necessarily platform agnostic
- Have a blueprint of your data center

IaC makes changes idempotent, consistent, repeatable, and predictable. 

## What is Terraform?
Inmutable: don't change the actual correct infrastructure.
IaC provisioning language based on HCL or JSON
Declarative: you don't put the steps to things to be build on.

The Private Module Registry is available in all versions of Terraform except for Open Source.

Terraform binary is available:
- Linux
- Windows
- Solaris
- macOS
- FreeBSD

VCS providers supports (January 2022):
- GitHub, GitHub.com (OAuth), GitHub Enterprise
- GitLab.com, GitLab EE & CE
- Bitbucket Cloud & Server
- Azure DevOps Server & Services

From Terraform 0.13 and above, `terraform init` can now automatically download community providers.

You can use constraints like the following:
```tf
terraform {
  required_version = ">= 0.12"
}
```

To ensure the version of Terraform. In this case, from this Terraform version it is important because it is when most changes were introduced.

### Integration with Vault
Terraform has no mechanism to redact or protect secrets that are returned via data sources, so secrets read via the provider will be persisted into the **Terraform state**, into any plan files, and in some cases in the console output.


### Providers
If you want to use tthe same provider with different configurations for different resource, you must use the `alias`meta-argument to implement it.

When downloading provider plugins, this are stored on the `.terraform/providers` directory (in the current working directory) by default.

Terraform relies on plugins called "providers" to interact with remote systems.


### Provisioners
If a resource fails to be correctly provisioned, it will be marked as tainted. Terraform cannot roll back and destroy the resource. The reason is because the resource is created.

### Dependencies
Terraform analyzes any expressions within a resource block to find references to other objects and treats those references as **implicit ordering requirements** when creating, updating, or destroying resources.

Some dependencies are not visible to Terraform. The `depends_on` is accepted by any resource and accepts a list of resources to create explicit dependencies for.

### Commands

Terraform will prompt for confirmation unless the `-auto-approve` flag is indicated. This happens in both
`terraform destroy` and `terraform apply`.

`terraform apply`:
- it has a lmit of concurrent operations (**default is 10**). You can modify this vvalue with the `-paralellism=n` argument.

Environment variables in Terraofrm must be in `TF_VAR_name` format. `TF_VAR` it is the the must prefix.

`terraform console` provides an interactive console for evaluating expressions.

`terraform import` imports existing resources into Terraform. This **DOES NOT GENERATE CONFIGURATION**. You still need to write a configuration block for the resource.

`terraform force-unlock` removes the lock on the state for the current configuration.

`terraform state` is used for advanced state managemnt.

#### Replace resource
`terraform apply -replace=<RESOURCE>`.

Second way is to `terraform destroy -target <VM>`. Then, run `terraform apply`.

### Variables
`TF_LOG` enables detailed logs (**stderr**). You can set it as: `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR`. This change the verbosity of the logs. `TRACE` it is the most verbose. 


#### Types
The available types are: `string`, `number`, `bool`, `list` (or tuple), `map` (or object).

#### `for_each`
`["INDEX"]` where `INDEX` is an alphanumerical key index into a resource with multiple instances specified by the `for_each` meta-argument.

### Conventions
Use 2 spaces between each nesting level to improve the readability.

### Functions
**index** finds the element index for a given value in a list (starting with index 0).

**lookup**: `lookup( <map>, "<key>", "<defaultValue>" )`. It will retrieve the value of a single element from a map. If it doesn't exist the key, it will return the given default value.

**join**: `join( "<delimiter>", <list> )` concatenate together all the elements of a given list of strings with the given delimiter.

## Terraform Cloud / Enterprise
Private module registry: you can publish and maintain a set of custom modules. The format should be: `<HOSTNAME>/<NAMESPACE>/<NAME>/<PROVIDER>`.

[Characteristics of Terraform versions](https://www.datocms-assets.com/2885/1602500234-terraform-full-feature-pricing-tablev2-1.pdf)

### Terraform Enterprise
Often installed on-premises or in a public cloud. TFE provides many features that aren not available with Terraform OSS.

A Terraform Enterpsie install *that is provisioned on a network that does not have Internet access* is generally known as an air-gapped install. You will require to pull updates, providers, etc. from external sources.

## Modules
The declarations in a module call (besides `source` and `version`) refer to the variables that are going to be passed into the child module.

To download and update modules:
```tf
terraform get
```
or
```tf
terraform init
```

### From GitHub
In the source declaration, it must follow the next syntax
`<GitLink>?ref=<VALUE>`.
- **VALUE** can ve a tag, branch. Anything that a `git checkout` can use.

### Publish a **Terraform Public Module**
- Must be on GitHub and must be a public repo.
- Named `terraform-<Provider>-<Name>`.
- Repository description: simple one-sentence.
- [Standard module structure](https://www.terraform.io/language/modules/develop#standard-module-structure)
- **x.y.<** tags for releases.

### Outputs
Aside from having **input** variables, you can have output variables to be used outside the module. This variables are accesed by `module.<ModuleName>.<OutputName>`.

## Workspace
Switch to a another workspace:
```tf
terraform workspace select <WorkspaceName>
```

Create a new workspace:
```tf
terraform workspace new <NameWorkspace>
```

The local state when working with spaces is stored at a directory called `terraform.tfstate.d`.

## [Debugging](https://www.terraform.io/internals/debugging)
To enable logs se the `TF_LOG` environment variable to any value: `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR` to change the verbosity. `TRACE` is the most verbose and it is the default if TF_LOG is set to something other than a log level name.

To persist logged output you can set `TF_LOG_PATH`

## Security
The only method that will not result in the username/password being written to the state file is environment variables.

## Alias
To use a specific configuration of provider, you need to use the varibale `provider` in your resource:
```tf
resource "aws_instance" "vault" {
  provider                    = aws.west
  ami                         = data.aws_ami.amzlinux2.id
  instance_type               = "t3.micro"
  ...
}
```

## State file
In this case, since there is a state file with resources, Terraform will match the desired state of no resources since the configuration file doesn't include any resources. Therefore, all resources defined in the state file will be destroyed.

## `terraform apply`
The `terraform apply` command is used to apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a `terraform plan` execution plan.

## `terraform apply`
The optional `-out` flag can be used to save the generated plan to a file for later execution with `terraform apply`, which can be useful when running Terraform in automation.

## Best practices
Although main.tf is the standard name, it's not necessarily required. Terraform will look for any file with a `.tf` or `.tf.json` extension when running terraform commands.

## Credentials
You can use methods such as static credentials, environment variables, share credentials/configuration file, or other methods. 

