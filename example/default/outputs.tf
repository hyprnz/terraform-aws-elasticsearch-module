output "es_domain_arn" {
  description = "The ARN of the Elastic Search domain."
  value       = module.example.es_domain_arn
}

output "es_domain_id" {
  description = "Unique identifier for the Elastic Search domain"
  value       = module.example.es_domain_id
}

output "es_domain_name" {
  description = "The name of the Elasticsearch domain"
  value       = module.example.es_domain_name
}

output "es_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = module.example.es_endpoint
}

output "es_kibana_endpoint" {
  description = "Domain-specific endpoint for kibana"
  value       = module.example.es_kibana_endpoint
}

output "es_kms_key_arn" {
  description = "The ARN of the key used to encrypt data at rest"
  value       = module.example.es_kms_key_arn
}

output "es_kms_key_id" {
  description = "The globally unique identifier for the key used to encrypt data at rest"
  value       = module.example.es_kms_key_id
}

output "es_vpc_security_group_id" {
  description = "The ID of the security group configured for the Elastic Search Domain"
  value       = module.example.es_kms_key_id
}

output "es_vpc_security_group_name" {
  description = "The Name of the security group configured for the Elastic Search Domain"
  value       = module.example.es_vpc_security_group_name
}

output "es_vpc_security_group_arn" {
  description = "The ARN of the security group configured for the Elastic Search Domain"
  value       = module.example.es_vpc_security_group_arn
}

output "es_cloudwatch_log_group_name" {
  description = "The Name of the Cloudwatch Log Group where ES Domain cluster logs are sent to"
  value       = module.example.es_cloudwatch_log_group_name
}

output "es_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group where ES Domain cluster logs are sent to"
  value       = module.example.es_cloudwatch_log_group_arn
}