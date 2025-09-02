resource "datadog_integration_aws_account" "this" {
  aws_account_id = var.aws_account_id
  aws_partition  = "aws"
  aws_regions {
    include_all  = false
    include_only = ["ap-northeast-1", "us-east-1"]
  }

  auth_config {
    aws_auth_config_role {
      role_name = var.role_name
    }
  }

  logs_config {
    lambda_forwarder {}
  }

  metrics_config {
    automute_enabled          = false
    collect_cloudwatch_alarms = false
    collect_custom_metrics    = false
    enabled                   = false
    namespace_filters {}
    tag_filters {}
  }

  resources_config {
    cloud_security_posture_management_collection = false
    extended_collection                          = false
  }

  traces_config {
    xray_services {
      include_all = false
    }
  }
}
