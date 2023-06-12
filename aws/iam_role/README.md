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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.aws_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.service_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_condition_list"></a> [aws\_condition\_list](#input\_aws\_condition\_list) | n/a | <pre>list(object({<br>    test     = string,<br>    variable = string,<br>    values   = set(string)<br>  }))</pre> | `[]` | no |
| <a name="input_aws_list"></a> [aws\_list](#input\_aws\_list) | n/a | `set(string)` | `[]` | no |
| <a name="input_custom_assume_policy_jsons"></a> [custom\_assume\_policy\_jsons](#input\_custom\_assume\_policy\_jsons) | n/a | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | n/a | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | n/a | `set(string)` | n/a | yes |
| <a name="input_service_condition_list"></a> [service\_condition\_list](#input\_service\_condition\_list) | n/a | <pre>list(object({<br>    test     = string,<br>    variable = string,<br>    values   = set(string)<br>  }))</pre> | `[]` | no |
| <a name="input_service_list"></a> [service\_list](#input\_service\_list) | n/a | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role"></a> [role](#output\_role) | n/a |
<!-- END_TF_DOCS -->