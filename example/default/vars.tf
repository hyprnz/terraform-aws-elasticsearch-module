variable "es_domain" {
  type        = string
  description = "Name for the Elastic Search Domain"
  default     = null
}

variable "vpc_name" {
  type        = string
  description = "The Name of the vpc to install the ElasticSearch domain"
  default     = null
}

variable "iam_role_arns" {
  type        = list(string)
  description = "List of Role arns that define access to the es domain"
}

variable "security_groups_ingress_source" {
  type        = list(string)
  description = "List Security Group IDs allowed ingress to the ES Domain"
}

variable "es_master_user_arn" {
  type        = string
  description = "ARN of role to be admin"
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}