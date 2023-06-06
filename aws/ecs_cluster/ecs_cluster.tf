resource "aws_ecs_cluster" "this" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = var.container_insights_enabled ? "enabled" : "disabled"
  }

  dynamic "configuration" {
    for_each = var.cluster_configuration != null ? [var.cluster_configuration] : []

    content {
      execute_command_configuration {
        kms_key_id = configuration.value.execute_command_configuration.kms_key_id
        logging    = configuration.value.execute_command_configuration.logging
        dynamic "log_configuration" {
          for_each = configuration.value.execute_command_configuration.log_configuration != null ? [configuration.value.execute_command_configuration.log_configuration] : []
          content {
            cloud_watch_encryption_enabled = try(log_configuration.value.cloud_watch_encryption_enabled, null)
            cloud_watch_log_group_name     = try(log_configuration.value.cloud_watch_log_group_name, null)
            s3_bucket_name                 = try(log_configuration.value.s3_bucket_name, null)
            s3_bucket_encryption_enabled   = try(log_configuration.value.s3_bucket_encryption_enabled, null)
            s3_key_prefix                  = try(log_configuration.value.s3_key_prefix, null)
          }
        }
      }
    }
  }

  tags = {
    "Name" = var.name
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [
    "FARGATE_SPOT",
    "FARGATE"
  ]

  dynamic "default_capacity_provider_strategy" {
    for_each = { for cp in var.default_capacity_provider_strategies : cp.capacity_provider => cp }

    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      base              = default_capacity_provider_strategy.value.base
      weight            = default_capacity_provider_strategy.value.weight
    }
  }
}
