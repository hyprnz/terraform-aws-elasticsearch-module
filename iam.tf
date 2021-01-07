data "aws_iam_policy_document" "es_access_policy" {
  count = var.enabled ? 1 : 0

  statement {
    effect = "Allow"

    actions = var.iam_actions

    resources = [
      aws_elasticsearch_domain.this[0].arn,
      format("%s/*", aws_elasticsearch_domain.this[0].arn)
    ]

    principals {
      type        = "AWS"
      identifiers = var.iam_role_arns
    }
  }
}

data "aws_iam_policy_document" "es_log_group_access_policy" {
  count = var.enabled && local.log_publishing_enabled ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream"
    ]

    resources = ["arn:aws:logs:*"]

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }
  }
}
