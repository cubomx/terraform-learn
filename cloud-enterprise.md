# Terraform Cloud & Enteprise

## [Login](https://learn.hashicorp.com/tutorials/terraform/cloud-login)

## Terraform Cloud
Application to use Terraform collaboratively.
- Runs
- Shared state and secret data
- Access control for approving changes to infra
- Private registry
- Detailed policy controls



### Terraform Enteprise
Self-hosted distro of Terraform Cloud:
- Advanced security
- Compliance needs

## [Workspace](https://www.terraform.io/cloud-docs/workspaces)
- Config
- Variables
- Run
    - Plan
    - Sentinel (policies, what you can/cannot do)
    - Apply
- Wrap everything around a set of permissions

Output: state file

Each working directory has:
- Configuration
- State data
- Variables

### Kinds
Terraform Cloud: workspaces are **required**. Give granular access to individuals/groups to 1+.

Terraform CLI: workspaces are **associated** to a specific working directory


### Recommendations
Group meaningful infrastructure collections. This is going to be separate directories. This collections with workspaces instead of directories.  

### Additional content
- State version: retains backups of its previous state files.
- Run history: record of all run activity.


## [Driven-Runs](https://www.terraform.io/cloud-docs/run/ui)
Every workspace is associated with a specific branch of a VCS repo of Terraform configurations (*UI & VCS Workflow*).A speculative plan will be trigger when a pull request is opened against the branch.

### Automatic Runs
In a workspace linked to a VCS repo, runs start automatically when you merge or commit changes to version control.

### Manually Runs
When the code in VC hasn't changed but you modified something outside (**variables**), you can manually start a run from the UI.

### Behaviour
When a run is been running in a workspace, no other run can be trigger.

#### Pull Request
Its going to check if a speculative plan should be run:
- Pull requests from the same repo
- Only run where automatic speculative plans are allowed
- Trigger in workspaces connected to that pul request's destination branch
- If a workspace is configured to only track/treat certain directories in a repo as relevant.
- The repository won't know the status of the apply


## Sentinel
It is an embedded policy-as-code framework integraded with the Hashicorp Enterprise products:
- Fine-grained
- Logic-based policy decisions

It is language and policy framework, that restricts actions, allowed behaviors. 

## Terraform Pricing
--------------------------------------
| Free | Team & Governance | Business |
| ---- | ----------------- | -------- |
| State management | Team management | SSO, self-hosted agents, audit logs |
| Remote operations | Sentinel policy as code | Custom concurrency |
| Private module registry | Policy enforcement | Self-hosted option |
| Community support | Cloud SLA & support | Premium support & services |