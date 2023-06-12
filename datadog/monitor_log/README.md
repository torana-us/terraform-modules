

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
| <a name="input_enable_logs_sample"></a> [enable\_logs\_sample](#input\_enable\_logs\_sample) | n/a | `bool` | `true` | no |
| <a name="input_escalation_message"></a> [escalation\_message](#input\_escalation\_message) | n/a | `string` | `null` | no |
| <a name="input_evaluation_delay"></a> [evaluation\_delay](#input\_evaluation\_delay) | * Set alert conditions | `number` | `60` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | delete even if it’s referenced by other resources | `bool` | `false` | no |
| <a name="input_groupby_simple_monitor"></a> [groupby\_simple\_monitor](#input\_groupby\_simple\_monitor) | n/a | `bool` | `false` | no |
| <a name="input_include_tags"></a> [include\_tags](#input\_include\_tags) | n/a | `string` | `false` | no |
| <a name="input_message"></a> [message](#input\_message) | n/a | `string` | n/a | yes |
| <a name="input_monitor_thresholds"></a> [monitor\_thresholds](#input\_monitor\_thresholds) | n/a | <pre>object({<br>    critical_recovery = optional(string)<br>    ok                = optional(string)<br>    unknown           = optional(string)<br>    warning           = optional(string)<br>    warning_recovery  = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | * Notify your team | `string` | n/a | yes |
| <a name="input_new_group_delay"></a> [new\_group\_delay](#input\_new\_group\_delay) | n/a | `number` | `null` | no |
| <a name="input_notify_audit"></a> [notify\_audit](#input\_notify\_audit) | If this monitor is modified, notify | `bool` | `false` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | n/a | `number` | n/a | yes |
| <a name="input_query"></a> [query](#input\_query) | logs(query).index(index\_name).rollup(rollup\_method[, measure]).last(time\_window) operator # | `string` | n/a | yes |
| <a name="input_renotify_interval"></a> [renotify\_interval](#input\_renotify\_interval) | n/a | `number` | `null` | no |
| <a name="input_renotify_occurrences"></a> [renotify\_occurrences](#input\_renotify\_occurrences) | n/a | `number` | `null` | no |
| <a name="input_renotify_statuses"></a> [renotify\_statuses](#input\_renotify\_statuses) | n/a | `set(string)` | `[]` | no |
| <a name="input_require_full_window"></a> [require\_full\_window](#input\_require\_full\_window) | n/a | `bool` | `false` | no |
| <a name="input_restricted_roles"></a> [restricted\_roles](#input\_restricted\_roles) | Restrict editing of this monitor | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `set(string)` | n/a | yes |
| <a name="input_timeout_h"></a> [timeout\_h](#input\_timeout\_h) | n/a | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datadog_monitor"></a> [datadog\_monitor](#output\_datadog\_monitor) | n/a |
<!-- END_TF_DOCS -->