variable "es_domain" {
  type        = string
  description = "Name for the Elastic Search Domain"
  default     = null
}

variable "es_vpc_id" {
  type        = string
  description = "The ID of the VPC to configure the ElasticSearch domain with"
  default     = ""
}

variable "es_subnet_ids" {
  type        = list(string)
  description = "A List of subnet ids to associate with the ElasticSearch domain."
  default     = []
}

variable "allowed_cdir_blocks" {
  type        = list(string)
  description = "A List of cdir blocks to assign to the VCP security group"
  default     = []
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