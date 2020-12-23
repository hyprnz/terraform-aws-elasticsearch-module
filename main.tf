locals {
  kms_key_needs_creating = var.enabled && var.es_encryption_enabled && var.kms_key_auto_create ? true : false
  kms_key_id             = !local.kms_key_needs_creating ? var.es_encryption_kms_key_id : aws_kms_key.es_domain[0].key_id

  az_count = var.use_all_azs_in_region ? length(data.aws_availability_zones.available.names) : var.es_az_count

  default_tags = {
    "Managed By"     = "Terraform",
    "Module"         = "terraform-aws-elasticsearch-module",
    "Resource Owner" = "Elasticsearch Cluster ${format("%v", var.es_domain)}"
  }
}
resource "aws_security_group" "es_vpc" {
  count       = var.enabled ? 1 : 0
  name        = var.es_domain
  description = "ElasticSearch Domain for ${var.es_domain}"
  vpc_id      = data.aws_vpc.this[0].id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      data.aws_vpc.this[0].cidr_block,
    ]
  }
}

resource "aws_iam_service_linked_role" "es_default" {
  count = var.enabled ? 1 : 0
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "this" {
  count                 = var.enabled ? 1 : 0
  domain_name           = var.es_domain
  elasticsearch_version = var.es_version

  cluster_config {
    instance_type  = var.es_data_node_instance_type
    instance_count = var.es_data_node_count

    dedicated_master_enabled = var.es_dedicated_node_enabled
    dedicated_master_type  = var.es_dedicated_node_instance_type
    dedicated_master_count = var.es_dedicated_node_count

    zone_awareness_enabled = var.es_az_aware

    dynamic "zone_awareness_config" {
      for_each = var.es_az_aware && local.az_count > 1 ? [true] : []
      content {
        availability_zone_count = local.az_count
      }
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
    security_group_ids = [aws_security_group.es_vpc[0].id]
  }

  advanced_options = var.es_advanced_options

  encrypt_at_rest {
    enabled    = var.es_encryption_enabled
    kms_key_id = local.kms_key_id
  }

  access_policies = <<-CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:domain/${var.es_domain}/*"
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = merge({
    Name = var.es_domain
  },
    local.default_tags, var.tags
  )

  depends_on = [aws_iam_service_linked_role.es_default]
}