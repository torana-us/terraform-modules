output "ecs_task_definition" {
  value = aws_ecs_task_definition.this
}

output "event_rule" {
  value = aws_cloudwatch_event_rule.this
}

output "event_target" {
  value = aws_cloudwatch_event_target.this
}
