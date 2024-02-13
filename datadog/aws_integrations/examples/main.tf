data "aws_caller_identity" "self" {}

module "aws_integration" {
  source           = "../"
  aws_account_id   = data.aws_caller_identity.self.account_id
  aws_account_name = "example"
  role_name        = "datadog-aws-integration-role-example"
}

terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    datadog = {
      source  = "datadog/datadog"
      version = ">= 3.0.0"
    }
  }
}

provider "datadog" {
  app_key = var.datadog_app_key
  api_key = var.datadog_api_key
}

variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}
