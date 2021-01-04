resource "aws_kms_key" "es_domain" {
  count = var.enabled ? 1 : 0

  description             = format("KMS key for ES Domain %s", var.es_domain)
  deletion_window_in_days = 30

  tags = merge({
    "Name" = format("%s-key", var.es_domain)
    }, local.default_tags, var.tags
  )
}

resource "aws_kms_alias" "es_domain" {
  count = var.enabled ? 1 : 0

  name          = format("alias/elastic-search-service/%s", var.es_domain)
  target_key_id = aws_kms_key.es_domain[0].key_id
}