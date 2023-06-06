#tfsec:ignore:aws-iam-no-policy-wildcards TODO:HIGH
#tfsec:ignore:aws-s3-enable-bucket-encryption TODO:HIGH
#tfsec:ignore:aws-s3-encryption-customer-key TODO:HIGH
#tfsec:ignore:aws-s3-enable-bucket-logging TODO:MEDIUM
#tfsec:ignore:aws-s3-enable-versioning TODO:MEDIUM
resource "aws_s3_bucket" "datadog_logs_forwarder_failed_logs" {
  bucket = "datadog-logs-forwarder-failed-logs-${var.stream_name_suffix}"
}

resource "aws_s3_bucket_ownership_controls" "datadog_logs_forwarder_failed_logs" {
  bucket = aws_s3_bucket.datadog_logs_forwarder_failed_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "datadog_logs_forwarder_failed_logs" {
  bucket = aws_s3_bucket.datadog_logs_forwarder_failed_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

