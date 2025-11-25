

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | 3.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_integration_aws_account.this](https://registry.terraform.io/providers/Datadog/datadog/latest/docs/resources/integration_aws_account) | resource |
| [datadog_integration_aws_external_id.this](https://registry.terraform.io/providers/Datadog/datadog/latest/docs/resources/integration_aws_external_id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_id"></a> [external\_id](#output\_external\_id) | n/a |
<!-- END_TF_DOCS -->