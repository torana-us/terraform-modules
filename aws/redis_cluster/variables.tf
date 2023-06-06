variable "replication_group_id" {
  type        = string
  description = "cluster name"
}

variable "node_type" {
  type        = string
  description = "instance type"
}

variable "description" {
  type    = string
  default = null
}

variable "engine_version" {
  type        = string
  description = "redis version"
}

variable "port" {
  type    = number
  default = 6379
}

variable "num_node_groups" {
  type        = number
  description = <<EOT
  Shard's number
  specifying than 1, Cluster mode enabled
EOT
}

variable "replicas_per_node_group" {
  type        = number
  description = "node's number per shard"
}

variable "parameter_group_name" {
  type = string
}

variable "security_group_ids" {
  type = set(string)
}

variable "maintenance_window" {
  type = string
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = false
}

variable "automatic_failover_enabled" {
  type    = bool
  default = null
}

variable "subnet_ids" {
  type = set(string)
}
