resource "aws_kinesis_firehose_delivery_stream" "datadog_logs_forwarder" {
  name        = "datadog-logs-forwarder-${var.stream_name_suffix}"
  destination = "http_endpoint"

  http_endpoint_configuration {
    name               = "Datadog"
    access_key         = "set_real_datadog_api_key_manually"
    buffering_interval = 60 # seconds
    buffering_size     = 1  # MiB
    retry_duration     = 60 # seconds
    role_arn           = module.datadog_logs_forwarder_role.role.arn
    s3_backup_mode     = "FailedDataOnly"
    url                = "https://aws-kinesis-http-intake.logs.datadoghq.com/v1/input"

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.datadog_logs_forwarder.name
      log_stream_name = aws_cloudwatch_log_stream.datadog_logs_forwarder_destination_delivery.name
    }

    processing_configuration {
      enabled = false
    }

    request_configuration {
      content_encoding = "GZIP"

      dynamic "common_attributes" {
        for_each = var.common_attributes_list

        content {
          name  = common_attributes.value.name
          value = common_attributes.value.value
        }
      }
    }

    s3_configuration {
      bucket_arn          = aws_s3_bucket.datadog_logs_forwarder_failed_logs.arn
      compression_format  = "GZIP"
      error_output_prefix = "destination-delivery"
      role_arn            = module.datadog_logs_forwarder_role.role.arn
      buffering_interval  = 60 # seconds
      buffering_size      = 1  # MiB

      cloudwatch_logging_options {
        enabled         = true
        log_group_name  = aws_cloudwatch_log_group.datadog_logs_forwarder.name
        log_stream_name = aws_cloudwatch_log_stream.datadog_logs_forwarder_backup_delivery.name
      }
    }
  }



  lifecycle {
    ignore_changes = [
      http_endpoint_configuration[0].access_key
    ]
  }
}

module "datadog_logs_forwarder_role" {
  source  = "app.terraform.io/torana/iam_role/aws"
  version = "v0.2.2"

  name = "datadog-logs-forwarder-role-${var.env}"
  service_list = [
    "firehose.amazonaws.com",
  ]
  policy_arns = [
    aws_iam_policy.datadog_logs_forwarder_failed_logs.arn
  ]
}

resource "aws_iam_policy" "datadog_logs_forwarder_failed_logs" {
  name = "datadog-logs-forwarder-policy-${var.env}"

  policy = data.aws_iam_policy_document.datadog_logs_forwarder_failed_logs.json
}

#tfsec:ignore:aws-iam-no-policy-wildcards TODO: HIGH
data "aws_iam_policy_document" "datadog_logs_forwarder_failed_logs" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [aws_s3_bucket.datadog_logs_forwarder_failed_logs.arn]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.datadog_logs_forwarder_failed_logs.arn}/*"]
  }
}

#tfsec:ignore:aws-cloudwatch-log-group-customer-key TODO:LOW
resource "aws_cloudwatch_log_group" "datadog_logs_forwarder" {
  name = "/aws/kinesisfirehose/datadog-logs-forwarder-${var.env}"
}

resource "aws_cloudwatch_log_stream" "datadog_logs_forwarder_destination_delivery" {
  name           = "destination-delivery"
  log_group_name = aws_cloudwatch_log_group.datadog_logs_forwarder.name
}

resource "aws_cloudwatch_log_stream" "datadog_logs_forwarder_backup_delivery" {
  name           = "backup-delivery"
  log_group_name = aws_cloudwatch_log_group.datadog_logs_forwarder.name
}
