resource "datadog_integration_aws_account" "this" {
  aws_account_id = var.aws_account_id
  aws_partition  = "aws"
  aws_regions {
    include_only = ["ap-northeast-1", "us-east-1"]
  }

  auth_config {
    aws_auth_config_role {
      role_name   = var.role_name
      external_id = datadog_integration_aws_external_id.this.id
    }
  }

  logs_config {
    lambda_forwarder {}
  }

  metrics_config {
    namespace_filters {}
  }

  resources_config {}

  traces_config {
    xray_services {}
  }
}

resource "datadog_integration_aws_external_id" "this" {}
