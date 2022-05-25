# Modules

## What are modules?
There is not limit to the complexity of a single Terraform configuration file. But, you may face the next problems:
- Understanding and navigating the configuration files.
- Updating the configuration (updating one section may cause unintended consequences to other parts)
- Duplication of similar blocks of configuration.
- Collaborate

## Why using modules?
- Organize: easier to navigate, understand, and update.
- Encapsulate: avoid unintended consequences, changing other parts and not reusing same name to different resources.
- Re-use configuration: save time and reduce costly errros.
- Consistency & best practices: easier to understand, best practices are applied.

## What is a Terraform Module
Is a set of **Terraform configuration files** in a single directory. Even if you don't separate your configuration, you a *root module*. When running a Terraform command this will be applied to the working directory. To use innner directories/child module, you must call them in a **module block**.

## Best Practices
- Name your provider `terraform-<Provider>-<Name>`.
- Start writing your configuration with modules in mind.
- Use local modules to organize & encapsulate your code.
- Find useful modules in the public **Terraform Registry**.
- Publish & share modules with your team.

## Use Modules
You must pass the necessary *input variables* to the module configuration. This values are passed as arguments in the *module block*. 

To get a non-local module, this will be installed in the `.terraform/modules`. The commands that will provoke this install are `terraform init` or `terraform get`.

## Module Structure

This is a recommendation but, you can use any file structure.
```
.
|---- LICENSE
|---- README.md
|---- main.tf
|---- variables.tf
|---- outputs.tf
```

Files that you don't distribute them as part of your module:
- `terraform.tfstate` & `terraform.tfstate.backup`
- `.terraform`: directory contains the modules & plugins used.
- `*.tfvars`

Be sure that this files aren`t tracked by your Version Control System because some of them may contain secret information.

Modules will inherit the provider from the enclosing configuration.

## Variables
Variables declared in modules that aren't given a default value are required, and so must be set whenever you use the module.

## Recommended Pattern
**Scope the requirements into appropiate modules**. Modules should be opinionated and designed to do one thing well. Aim for small & simple to start when scoping a module:
- *Encapsulation*: group infrastructure that is always deployed together
- *Privileges*: restrict modules to privilege boundaries.
- *Volatility*: separate long-lived infrastructure from short-lived.

**MVP module**. Modules are never complete. Aim you first few module versions to meet the MVP standards.
- Never code for edge cases.
- Module that works at least 80% of use cases.
- Narrow scope and should not do multiple things.
- Only expose the most commonly modified arguments as variables.


## Refactor into modules
When you first create all your configuration in the root module, and you now have separated it into modules, you must be aware of the following: when you move your configuration to a child module, these resources may have to change and lose the link to the state.

You have two options:
- `terraform state mv`: this was the old way to do it.
- Use the `block moved`:
```tf
moved {
  from = aws_instance.example
  to = module.ec2_instance.aws_instance.example
}

moved {
  from = aws_security_group.sg_8080
  to = module.security_group.aws_security_group.sg_8080
}
```

After you apply the changes with the **block moved**, you can remove it and continue working without it.

## Versions
Terraform Cloud's private module registry & public Terraform Registry support version constraints. It is highly recommended to declare the version.

## [Variables](https://www.terraform.io/language/values/variables)
They must be declared using a `variable` block.
```tf
variable "<name>" {}
```

Arguments:
- **default**: default value (making the variable optional)
- **type**: what values are accepted
- **description**: input variable's documentation
- **validation**: block to define validation rules.
- **sensitive**: exclude from showing in the Terraform UI
- **nullable**: if the variable `can be null`