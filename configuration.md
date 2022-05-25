# Read & Write Configuration

## [Resources](https://www.terraform.io/language/resources)
These are the most important element. Each **resource block** describes 1+ infrastructure objects.

Meta-arguments that can be used with every resource type:
- `depends_on`
- `count`
- `for_each`
- `provider`
- `lifecycle`

## [Data Sources](https://www.terraform.io/language/data-sources)
Allow Terraform to *use information defined outside* of Terraform, defined by another separate Terraform configuration, or modified by functions. It is declared using a `data` block.

## [Resource Addressing](https://www.terraform.io/cli/state/resource-addressing)
It is a string that *identifies* 0+ more **resource instances** in your overall configuration. It is made up of two parts:
```
[module path][resource spec]
```

In some contexts, you may be allow to:
- Only refer to a module as a whole
- Omit the index for a multi-instance resource.

### Module path
It addresses a module within the tree of modules:
```
module.module_name[module_index]
```

### Resource spec
Addresses a specific resource instance in the selected module.

```
resource_type.resource_name[instance index]
```

## [References to Named Values](https://www.terraform.io/language/expressions/references)
- **Resources**: `<ResourceType><Name>` represents a **managed resource** of the given type and name.
- **Input Variables**: `var.<Name>`.
- **Locals Values**: `local.<Name>` value of the *local value* of the given name.
- **Child Module Outputs**: `module.<ModuleName>` value representing the results of a module block.
- **Data Sources**: `data.<DataType>.<Name>` is an object representing a **data resource** of the given data source type and name. 
- **Filesystem and Workspace Info**: 
    - `path.module`: filesystem path of the module where the expression is placed.
    - `path.root`: filesystem path of the root module of the configuration.
    - `path.cwd`: filesystem path of the current working directory. 
    - `terraform.workspace`: name of the currently selected *workspace*.

## [Resource Graph](https://www.terraform.io/internals/graph)
Terraform builds a dependency graph, this is used to generate plans, refresh state, and more.

## [Complex Types](https://www.terraform.io/language/expressions/type-constraints#complex-types)
It is a type that groups multiple values into a single value.

### Collection Types
Allows multiple values of *one* other type to be grouped together as a single value:
- list(...)
- map(...)
- set(...)

### Structural types
Allows multiple values of several distinct
- object(...): collection of named attributes (each with their own type)
- tuple(...): sequence of elements identified by a consecutive whole numbers starting with zero, where each element has its own type.

## Dynamic Expressions
**Locals** assign a name to an expression like a variable assigns a name to a vlue. **Expressions cannot be interpreted as variables**, but can be declared as `locals` in your configuration. You can reuse it multiple times.

### Conditional Expressions
**Conditional expresssions** determine the action of a configuration based on `true` or `false` values. 

### Share values from multiple instances
Use the `*` (splat expression) to capture all objects in a list that share an attribute. It iterates over all of the elements of a given list. Without it, Terraform will only return the first element.

Example:
```tf
output "private_addresses" {
  value = aws_instance.ubuntu[*].private_dns
}
```

### Dynamic blocks
A `dynamic` block acts much like a **`for`** expression, but produces nested blocks instead of a complex typed value. It iterates over a given complex value, and generates a nested block for each element of that complex value.

Structure:
```tf
dynamic "<Kind>"{
  for_each = <ComplexValue>
  content {
    value  
  }  
}
```

