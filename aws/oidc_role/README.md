<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_github_actions_role"></a> [github\_actions\_role](#module\_github\_actions\_role) | ../iam_role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy_document.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | GitHub repository name, e.g. ["repo:torana-us/terraform-modules:*",] | `set(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
