resource "aws_cloudwatch_log_subscription_filter" "datadog_logs_forwarder" {
  for_each = var.log_group_name_list

  name            = "filter-for-${each.value}-logs-forwarder"
  role_arn        = module.subscription_filter_role.role.arn
  log_group_name  = each.value
  filter_pattern  = ""
  destination_arn = aws_kinesis_firehose_delivery_stream.datadog_logs_forwarder.arn
}

module "subscription_filter_role" {
  source = "../iam_role"

  name = "subscription-filter-role-for-logs-forwarder-${var.env}"
  service_list = [
    "logs.amazonaws.com",
  ]
  policy_arns = [
    aws_iam_policy.subscription_filter_for_logs_forwarder.arn
  ]
}

resource "aws_iam_policy" "subscription_filter_for_logs_forwarder" {
  name = "subscription-filter-policy-for-logs-forwarder-${var.env}"

  policy = data.aws_iam_policy_document.subscription_filter_for_logs_forwarder.json
}

data "aws_iam_policy_document" "subscription_filter_for_logs_forwarder" {
  statement {
    effect = "Allow"
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
      "kinesis:PutRecord",
      "kinesis:PutRecords"
    ]
    resources = [aws_kinesis_firehose_delivery_stream.datadog_logs_forwarder.arn]
  }
}
