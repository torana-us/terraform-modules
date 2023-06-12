

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_monitor.this](https://registry.terraform.io/providers/Datadog/datadog/latest/docs/resources/monitor) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_window"></a> [alert\_window](#input\_alert\_window) | n/a | <pre>object({<br>    num  = number<br>    unit = string<br>  })</pre> | n/a | yes |
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | n/a | `string` | n/a | yes |
| <a name="input_deviations"></a> [deviations](#input\_deviations) | controls the sensitivity of the anomaly detection. | `number` | `2` | no |
| <a name="input_direction"></a> [direction](#input\_direction) | n/a | `string` | n/a | yes |
| <a name="input_message"></a> [message](#input\_message) | n/a | `string` | n/a | yes |
| <a name="input_metric_query"></a> [metric\_query](#input\_metric\_query) | n/a | `string` | n/a | yes |
| <a name="input_monitor_thresholds"></a> [monitor\_thresholds](#input\_monitor\_thresholds) | n/a | <pre>object({<br>    critical          = string<br>    critical_recovery = optional(string)<br>    ok                = optional(string)<br>    unknown           = optional(string)<br>    warning           = optional(string)<br>    warning_recovery  = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_seasonality"></a> [seasonality](#input\_seasonality) | n/a | `string` | `"daily"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datadog_monitor"></a> [datadog\_monitor](#output\_datadog\_monitor) | n/a |
<!-- END_TF_DOCS -->