resource "aws_iam_role" "this" {
  assume_role_policy   = data.aws_iam_policy_document.base.json
  name                 = var.name
  max_session_duration = var.max_session_duration

  tags = {
    "Name" = var.name
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "this" {
  role_name   = aws_iam_role.this.name
  policy_arns = var.policy_arns
}

data "aws_iam_policy_document" "base" {
  override_policy_documents = concat(
    data.aws_iam_policy_document.service_assume_policy[*].json,
    data.aws_iam_policy_document.aws_assume_policy[*].json,
    var.custom_assume_policy_jsons
  )
}

data "aws_iam_policy_document" "service_assume_policy" {
  count = length(var.service_list) > 0 ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      identifiers = var.service_list
      type        = "Service"
    }

    dynamic "condition" {
      for_each = var.service_condition_list

      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "aws_assume_policy" {
  count = length(var.aws_list) > 0 ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      identifiers = var.aws_list
      type        = "AWS"
    }

    dynamic "condition" {
      for_each = var.aws_condition_list

      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

