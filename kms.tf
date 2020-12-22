resource "aws_kms_key" "es_domain" {
  count = local.kms_key_needs_creating ? 1 : 0

  description             = "KMS key for ES Domain $[var.es_domain}"
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "es_domain" {
  count = local.kms_key_needs_creating ? 1 : 0

  name          = format("alias/%s", var.es_domain)
  target_key_id = aws_kms_key.es_domain[0].key_id
}