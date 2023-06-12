# terraformAliPractice

sandbox to create some resources on ali

## troubleshooting

- if no access key or secret set,
```console
Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid type option, support: access_key, sts, ecs_ram_role, ram_role_arn, rsa_key_pair
│
│   with provider["registry.terraform.io/hashicorp/alicloud"],
│   on exampleLogProj.tf line 1, in provider "alicloud":
│    1: provider "alicloud" {
│
```

- jumping in with terraform plan with no init first
```
terraform plan
╷
│ Error: Inconsistent dependency lock file
│
│ The following dependency selections recorded in the lock file are inconsistent
│ with the current configuration:
│   - provider registry.terraform.io/hashicorp/alicloud: required by this configuration but no version is selected
│
│ To make the initial dependency selections that will initialize the dependency
│ lock file, run:
│   terraform init
```