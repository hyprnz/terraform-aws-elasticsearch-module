variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
}

variable "es_domain_name" {
  type        = string
  description = "Name for the Elastic Search Domain.  Must start with a alphabet and be at least 3 and no more than 28 characters long."
  default     = null
}

variable "es_version" {
  type        = string
  description = "The version of Elasticsearch to provision"
  default     = "7.9"
}

variable "es_data_node_instance_type" {
  type        = string
  description = "The instance type for the ElasticSearch data nodes"
  default     = "t3.small.elasticsearch"
}

variable "es_data_node_count" {
  type        = number
  description = "The number of data nodes for the ElasticSearch Domain."
  default     = 3
}

variable "es_dedicated_node_instance_type" {
  type        = string
  description = "The instance type for the ElasticSearch dedicated nodes"
  default     = "t3.small.elasticsearch"
}

variable "es_dedicated_node_enabled" {
  type        = bool
  description = "Determines if the cluster should provision dedicated cluster nodes."
  default     = false
}

variable "es_dedicated_node_count" {
  type        = number
  description = "The number of dedicated nodes for the ElasticSearch Domain."
  default     = 1
}

variable "es_vpc_enabled" {
  type        = bool
  description = "Controls if the ElasticSearch Domain should bind to a VPC. If `false` cluster is provisioned outside a VPC"
  default     = true
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

variable "use_all_azs_in_region" {
  type        = bool
  description = "Defaults to use all availabile Availability Zones in the Region. Takes prescendence over `es_az_count`."
  default     = true
}

variable "es_az_aware" {
  type        = bool
  description = "Controls if the ElasticSeach domain should be AZ aware"
  default     = true
}

variable "es_az_count" {
  type        = number
  description = "The number of AZ's to use in theElasticSearch domain cluster. Not applied if `use_all_azs_in_region` is `true`."
  default     = 1
}

variable "es_ebs_volume_size" {
  type        = number
  description = "The size of EBS volumes attached to data nodes (in GiB). EBS volumes are attached to data nodes in the domain when this value is > `0`."
  default     = 0
}

variable "es_ebs_volume_type" {
  type        = string
  description = "The type of EBS volumes attached to data nodes."
  default     = "gp2"
}

variable "es_ebs_iops" {
  type        = number
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type."
  default     = 0
}

variable "es_advanced_security_options_enabled" {
  type        = bool
  description = "Enables Fine Grained Access Control within the ElasticSearch domain. This will require a management process to map IAM roles to ElasticSearch principals"
  default     = true
}

variable "es_internal_user_database_enabled" {
  type        = bool
  description = "Whether the internal user database is enabled. Defaults to `false`"
  default     = false
}

variable "es_master_user_arn" {
  type        = string
  description = "ARN for the master user. Has no effect if `es_internal_user_database_enabled` is set to `true`"
  default     = null
}

variable "es_master_user_name" {
  type        = string
  description = "The master user's username, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `es_internal_user_database_enabled` is set to `true`"
  default     = null
}

variable "es_master_user_password" {
  type        = string
  description = " The master user's password, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `es_internal_user_database_enabled` is set to `true`"
  default     = null
}

variable "es_encryption_enabled" {
  type        = bool
  description = "Enables encryption (at rest) for data in the ElasticSearch domain. Creates own KMS key for use in the ES Domain and Cloudwatch Log Groups"
  default     = true
}

variable "es_advanced_options" {
  type        = map(any)
  description = "Advanced configuration options in JSON format"
  default     = null
}

variable "security_groups_ingress_source" {
  type        = list(string)
  description = "List of security Group IDs allowed access to the cluster"
  default     = []
}

variable "automated_snapshot_start_hour" {
  type        = number
  description = "The hour(`UTC`) when snapshots are taken"
  default     = 12
}

variable "enforce_https_for_es_domain_endpoint" {
  type        = bool
  description = "Controls if the Elastic Search Domain endpoint is restricted to https only. Defaults to `true`"
  default     = true
}

variable "tls_security_policy_for_es_domain_endpoint" {
  type        = string
  description = "The name of the TLS security policy that needs to be applied to the HTTPS endpoint. Valid values: `Policy-Min-TLS-1-0-2019-07`(default) and `Policy-Min-TLS-1-2-2019-07`. "
  default     = "Policy-Min-TLS-1-0-2019-07"
}

variable "es_access_policy_statements" {
  type = list(object({
    name          = string
    actions       = list(string)
    resource_path = string
    role          = string
  }))
  description = "A list of IAM settings that build a number of IAM policy statements, that define the access policy for the cluster"
  default     = null
}

variable "log_index_slow_enabled" {
  type        = bool
  description = "Enables the `INDEX_SLOW_LOGS` to CloudWatch"
  default     = true
}

variable "log_search_slow_enabled" {
  type        = bool
  description = "Enables the `SEARCH_SLOW_LOGS` to CloudWatch"
  default     = true
}

variable "log_es_app_enabled" {
  type        = bool
  description = "Enables the `ES_APPLICATION_LOGS` to CloudWatch"
  default     = true
}

variable "log_audit_enabled" {
  type        = bool
  description = "Enables the `AUDIT_LOGS` to CloudWatch. Requires `es_advanced_security_options_enabled` to be `true`"
  default     = true
}

variable "log_publishing_rentention_in_days" {
  type        = number
  description = "Controls the rentation period in days the CloudWatch Log Group applies to published logs"
  default     = 30
}
variable "tags" {
  type        = map(any)
  description = "Tags to apply to all resources"
  default     = {}
}