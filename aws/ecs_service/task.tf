resource "aws_ecs_task_definition" "this" {
  family                = var.task_name
  container_definitions = var.container_definitions
  cpu                   = var.cpu
  memory                = var.memory

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]

  tags = merge({
    "Name" = var.task_name
  }, var.tags)

  lifecycle {
    ignore_changes = all
  }
}
