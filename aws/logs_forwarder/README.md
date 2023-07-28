# logs_forwarder

## Caution!

Kinesis Firehoseに設定するaccess_keyには、Datadog API KeyをAWSコンソールから設定する必要があります。
再apply時はDummy文字列で上書きされてしまうため、再設定してください。
Datadog API Keyは1passwordに保存してあります。

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_datadog_logs_forwarder_role"></a> [datadog\_logs\_forwarder\_role](#module\_datadog\_logs\_forwarder\_role) | ../iam_role | n/a |
| <a name="module_subscription_filter_role"></a> [subscription\_filter\_role](#module\_subscription\_filter\_role) | ../iam_role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.datadog_logs_forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.datadog_logs_forwarder_backup_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_cloudwatch_log_stream.datadog_logs_forwarder_destination_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_cloudwatch_log_subscription_filter.datadog_logs_forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_iam_policy.datadog_logs_forwarder_failed_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.subscription_filter_for_logs_forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.datadog_logs_forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_s3_bucket.datadog_logs_forwarder_failed_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.datadog_logs_forwarder_failed_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.datadog_logs_forwarder_failed_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.datadog_logs_forwarder_failed_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.subscription_filter_for_logs_forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_attributes_list"></a> [common\_attributes\_list](#input\_common\_attributes\_list) | n/a | <pre>set(object({<br>      name = string<br>      value = string<br>    }))</pre> | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_log_group_name_list"></a> [log\_group\_name\_list](#input\_log\_group\_name\_list) | n/a | `set(string)` | n/a | yes |
| <a name="input_stream_name_suffix"></a> [stream\_name\_suffix](#input\_stream\_name\_suffix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
