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


# basic commands

- init - prep working directory for other comands
- validate - check if config is valid
- plan - show changes required by current config
- apply - create or update infra
- destroy - destroys previously created infra

# try setting up terraform to create new log project, and log store

- in a file include
- provider "alicloud" with region
```
 resource "alicloud_log_project" "example" {
  name        = "tf-log"
  description = "created by terraform"
  tags        = { "test" : "test" }
}
```
- import a project
```
terraform import alicloud_log_project.example "{id of project}
```
- now when you try to plan it will take into account the imported item.
- note that when importing,
```hcl
"alicloud_log_project" "example" {} 
```
must be present in your tf project.
- after the import, you can check the details of your existing resource with
```
terraform state show alicloud_log_project.staging
```

- "unimport" a project
```
terraform state list
terraform state rm {name of resource}
```
