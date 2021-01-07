output "es_domain_arn" {
  description = "The ARN of the Elastic Search domain."
  value       = join("", aws_elasticsearch_domain.this[*].arn)
}

output "es_domain_id" {
  description = "Unique identifier for the Elastic Search domain"
  value       = join("", aws_elasticsearch_domain.this[*].domain_id)
}

output "es_domain_name" {
  description = "The name of the Elasticsearch domain"
  value       = join("", aws_elasticsearch_domain.this[*].domain_name)
}

output "es_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = join("", aws_elasticsearch_domain.this[*].endpoint)
}

output "es_kibana_endpoint" {
  description = "The Elastic Search Domain-specific endpoint for Kibana"
  value       = join("", aws_elasticsearch_domain.this[*].kibana_endpoint)
}

output "es_kms_key_arn" {
  description = "The ARN of the key used to encrypt data at rest"
  value       = join("", aws_kms_key.es_domain[*].arn)
}

output "es_kms_key_id" {
  description = "The globally unique identifier for the key used to encrypt data at rest"
  value       = join("", aws_kms_key.es_domain[*].key_id)
}

output "es_vpc_security_group_id" {
  description = "The ID of the security group configured for the Elastic Search Domain"
  value       = join("", aws_security_group.es_domain[*].id)
}

output "es_vpc_security_group_name" {
  description = "The Name of the security group configured for the Elastic Search Domain"
  value       = join("", aws_security_group.es_domain[*].name)
}

output "es_vpc_security_group_arn" {
  description = "The ARN of the security group configured for the Elastic Search Domain"
  value       = join("", aws_security_group.es_domain[*].arn)
}

output "es_cloudwatch_log_group_name" {
  description = "The Name of the Cloudwatch Log Group where ES Domain cluster logs are published"
  value       = join("", aws_cloudwatch_log_group.es_domain[*].name)
}

output "es_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group where ES Domain cluster logs are published"
  value       = join("", aws_cloudwatch_log_group.es_domain[*].arn)
}
