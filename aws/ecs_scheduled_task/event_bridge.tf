resource "aws_cloudwatch_event_rule" "this" {
  name                = var.name
  schedule_expression = var.schedule_expression
  event_bus_name      = var.event_bus_name
  is_enabled          = var.is_enabled

  tags = {
    "Name" = var.name
  }
}

resource "aws_cloudwatch_event_target" "this" {
  arn       = var.ecs_cluster_arn
  rule      = aws_cloudwatch_event_rule.this.name
  role_arn  = var.target_role_arn
  target_id = var.name
  input     = var.input

  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.this.arn
    platform_version    = var.platform_version
    network_configuration {
      assign_public_ip = true
      security_groups  = var.security_groups
      subnets          = var.subnets
    }
  }

  dead_letter_config {
    arn = var.dead_letter_queue_arn
  }

  retry_policy {
    maximum_event_age_in_seconds = var.maximum_event_age_in_seconds
    maximum_retry_attempts       = var.maximum_retry_attempts
  }

  lifecycle {
    ignore_changes = [
      ecs_target[0].task_definition_arn
    ]
  }
}


