terraform {
  required_version = ">= 1.1.0"
  required_providers {
    datadog = {
      source  = "Datadog/datadog"
      version = ">= 3.14.0"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
