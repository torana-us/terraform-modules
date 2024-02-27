locals {
  guess_port = can(regex("mysql", var.engine)) ? 3306 : can(regex("postgres", var.engine)) ? 5432 : null
  port       = var.port != null ? var.port : local.guess_port
}

#tfsec:ignore:aws-rds-encrypt-cluster-storage-data
#tfsec:ignore:aws-rds-specify-backup-retention
resource "aws_rds_cluster" "this" {
  cluster_identifier     = var.name
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  iam_roles              = var.iam_role_arns
  engine                 = var.engine
  engine_version         = var.engine_version
  port                   = local.port
  database_name          = var.database_name
  master_username        = var.db_user
  master_password        = var.db_pass

  skip_final_snapshot              = var.skip_final_snapshot
  final_snapshot_identifier        = "${var.name}-final"
  db_cluster_parameter_group_name  = var.db_cluster_parameter_group_name
  db_instance_parameter_group_name = var.db_instance_parameter_group_name
  enabled_cloudwatch_logs_exports  = var.enabled_cloudwatch_logs_exports
  backup_retention_period          = var.backup_retention_period

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_rds_cluster_instance" "this" {
  for_each = var.instances

  identifier         = each.key
  cluster_identifier = aws_rds_cluster.this.id

  engine                       = aws_rds_cluster.this.engine
  engine_version               = aws_rds_cluster.this.engine_version
  instance_class               = var.instance_class
  performance_insights_enabled = each.value.performance_insights_enabled
  promotion_tier               = each.value.tier
  ca_cert_identifier           = "rds-ca-ecc384-g1"
}


resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags = {
    Name = var.subnet_group_name
  }
}
