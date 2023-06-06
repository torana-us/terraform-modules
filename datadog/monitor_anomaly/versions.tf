terraform {
  required_version = ">= 1.1.0"
  required_providers {
    datadog = {
      source  = "Datadog/datadog"
      version = ">= 3.14.0"
    }
  }
}
