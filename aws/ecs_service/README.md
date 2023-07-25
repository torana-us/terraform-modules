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
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_provider_strategies"></a> [capacity\_provider\_strategies](#input\_capacity\_provider\_strategies) | n/a | <pre>list(object({<br>    capacity_provider = string<br>    base              = number<br>    weight            = number<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | n/a | yes |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | json | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | n/a | yes |
| <a name="input_deployment_controller"></a> [deployment\_controller](#input\_deployment\_controller) | n/a | `string` | CODE_DEPLOY | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | n/a | yes |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | n/a | `number` | n/a | yes |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | n/a | `string` | `null` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | n/a | <pre>list(object({<br>    container_name   = string<br>    container_port   = number<br>    target_group_arn = string<br>  }))</pre> | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | n/a | yes |
| <a name="input_network_configuration"></a> [network\_configuration](#input\_network\_configuration) | (optional) describe your variable | <pre>object({<br>    assign_public_ip = bool<br>    security_groups  = set(string)<br>    subnets          = set(string)<br>  })</pre> | n/a | yes |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | n/a | `string` | `null` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | n/a | `string` | `"TASK_DEFINITION"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | n/a | <pre>object({<br>    registry_arn   = string<br>    port           = number<br>    container_port = number<br>    container_name = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_task_name"></a> [task\_name](#input\_task\_name) | n/a | `string` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service"></a> [service](#output\_service) | n/a |
<!-- END_TF_DOCS -->
