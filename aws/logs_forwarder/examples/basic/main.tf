module "datadog_log_forwarder" {
  source = "../../"

  env             = "example"

  stream_name_suffix = "example-suffix"

  log_group_name_list = [
    aws_cloudwatch_log_group.example.name,
  ]

  common_attributes_list = [
    {
      name = "env"
      value = "example-env"
    },
    {
      name = "project"
      value = "example-project"
    }
  ]
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example"
}
