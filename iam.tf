data "aws_iam_policy_document" "es_access_policy" {
  count = var.enabled ? 1 : 0

  dynamic "statement" {
    for_each = var.es_access_policy_statements
    content {
      effect = "Allow"

      sid = statement.value.name

      actions = statement.value.actions

      resources = [
        format("%s/%s", aws_elasticsearch_domain.this[0].arn, statement.value.resource_path)
      ]

      principals {
        type        = "AWS"
        identifiers = [statement.value.role]
      }
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
