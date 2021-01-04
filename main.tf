# IAM role
# CW Logs

locals {
  az_count = var.use_all_azs_in_region ? length(data.aws_availability_zones.available.names) : var.es_az_count

  log_publishing_enabled = (var.log_index_slow_enabled || var.log_search_slow_enabled || var.log_es_app_enabled || var.log_audit_enabled) ? true : false

  default_tags = {
    "Managed By"     = "Terraform",
    "Module"         = "terraform-aws-elasticsearch-module",
    "Resource Group" = "Elasticsearch Cluster ${format("%v", var.es_domain)}"
  }
}

resource "aws_elasticsearch_domain" "this" {
  count                 = var.enabled ? 1 : 0
  domain_name           = var.es_domain
  elasticsearch_version = var.es_version

  cluster_config {
    instance_type  = var.es_data_node_instance_type
    instance_count = var.es_data_node_count

    dedicated_master_enabled = var.es_dedicated_node_enabled
    dedicated_master_type    = var.es_dedicated_node_instance_type
    dedicated_master_count   = var.es_dedicated_node_count

    zone_awareness_enabled = var.es_az_aware

    dynamic "zone_awareness_config" {
      for_each = var.es_az_aware && local.az_count > 1 ? [true] : []
      content {
        availability_zone_count = local.az_count
      }
    }
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = var.es_internal_user_database_enabled
    master_user_options {
      master_user_arn      = var.es_master_user_arn
      master_user_name     = var.es_master_user_name
      master_user_password = var.es_master_user_password
    }
  }

  ebs_options {
    ebs_enabled = var.es_ebs_volume_size > 0 ? true : false
    volume_size = var.es_ebs_volume_size
    volume_type = var.es_ebs_volume_type
    iops        = var.es_ebs_iops
  }

  vpc_options {
    subnet_ids         = data.aws_subnet_ids.this[0].ids
    security_group_ids = [aws_security_group.this[0].id]
  }

  domain_endpoint_options {
    enforce_https       = var.enforce_https_for_es_domain_endpoint
    tls_security_policy = var.tls_security_policy_for_es_domain_endpoint
  }

  advanced_options = var.es_advanced_options

  encrypt_at_rest {
    enabled    = var.es_encryption_enabled
    kms_key_id = aws_kms_key.es_domain[0].key_id
  }

  node_to_node_encryption {
    enabled = true
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  log_publishing_options {
    enabled                  = var.log_index_slow_enabled
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain[0].arn
  }

  log_publishing_options {
    enabled                  = var.log_search_slow_enabled
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain[0].arn
  }

  log_publishing_options {
    enabled                  = var.log_es_app_enabled
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain[0].arn
  }

  log_publishing_options {
    enabled                  = var.log_audit_enabled
    log_type                 = "AUDIT_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain[0].arn
  }

  tags = merge({
    Name = var.es_domain
    },
    local.default_tags, var.tags
  )
}

resource "aws_elasticsearch_domain_policy" "this" {
  count           = var.enabled ? 1 : 0
  domain_name     = aws_elasticsearch_domain.this[0].domain_name
  access_policies = data.aws_iam_policy_document.es_access_policy[0].json
}