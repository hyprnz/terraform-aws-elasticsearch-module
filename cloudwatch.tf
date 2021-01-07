resource "aws_cloudwatch_log_group" "es_domain" {
  count = var.enabled && local.log_publishing_enabled ? 1 : 0
  name  = format("/aws/elasticsearch-service/%s", var.es_domain)

  retention_in_days = var.log_publishing_rentention_in_days
}

resource "aws_cloudwatch_log_resource_policy" "es_domain" {
  count           = var.enabled && local.log_publishing_enabled ? 1 : 0
  policy_name     = format("%s-log-publishing", var.es_domain)
  policy_document = data.aws_iam_policy_document.es_log_group_access_policy[0].json
}