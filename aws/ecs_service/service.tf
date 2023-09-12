
resource "aws_ecs_service" "this" {
  name                    = var.service_name
  cluster                 = var.cluster_id
  task_definition         = replace(aws_ecs_task_definition.this.arn, "/:\\d+$/", "")
  launch_type             = var.launch_type
  platform_version        = var.platform_version
  enable_ecs_managed_tags = true
  enable_execute_command  = true
  desired_count           = var.desired_count
  propagate_tags          = var.propagate_tags

  // LB
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  dynamic "load_balancer" {
    for_each = { for l in var.load_balancers : l.container_name => l }
    content {
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
      target_group_arn = load_balancer.value.target_group_arn
    }
  }

  network_configuration {
    assign_public_ip = var.network_configuration.assign_public_ip
    security_groups  = var.network_configuration.security_groups
    subnets          = var.network_configuration.subnets
  }

  dynamic "capacity_provider_strategy" {
    for_each = { for cp in var.capacity_provider_strategies : cp.capacity_provider => cp }

    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      base              = capacity_provider_strategy.value.base
      weight            = capacity_provider_strategy.value.weight
    }
  }

  deployment_controller {
    type = var.deployment_controller
  }

  dynamic "service_registries" {
    for_each = var.service_registries != null ? { var.service_registries.registry_arn = var.service_registries } : {}

    content {
      registry_arn   = service_registries.value.registry_arn
      port           = service_registries.value.port
      container_port = service_registries.value.container_port
      container_name = service_registries.value.container_name
    }
  }

  dynamic "deployment_circuit_breaker" {
    for_each = var.deployment_circuit_breaker.enable ? [1] : []
    content {
      enable   = var.deployment_circuit_breaker.enable
      rollback = var.deployment_circuit_breaker.rollback
    }
  }

  tags = merge({
    "Name" = var.service_name
  }, var.tags)

  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
}
