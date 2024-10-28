locals {
  description                = var.description != null ? var.description : "${var.replication_group_id}'s Redis"
  automatic_failover_enabled = var.automatic_failover_enabled != null ? var.automatic_failover_enabled : var.replicas_per_node_group > 0
}

#tfsec:ignore:aws-elasticache-enable-in-transit-encryption
#tfsec:ignore:aws-elasticache-enable-at-rest-encryption
resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.replication_group_id
  node_type                  = var.node_type
  description                = local.description
  engine_version             = var.engine_version
  engine                     = var.engine
  port                       = var.port
  num_node_groups            = var.num_node_groups
  replicas_per_node_group    = var.replicas_per_node_group
  parameter_group_name       = var.parameter_group_name
  security_group_ids         = var.security_group_ids
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window            = var.snapshot_window
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  automatic_failover_enabled = local.automatic_failover_enabled
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.replication_group_id}-subnet"
  subnet_ids = var.subnet_ids
}
