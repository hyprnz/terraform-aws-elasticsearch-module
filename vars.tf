variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
}

variable "es_domain" {
  type        = string
  description = "Name for the Elastic Search Domain.  must start with a alphabet and be at least 3 and no more than 28 characters long."
  default     = null
}

variable "vpc_name" {
  type        = string
  description = "The Name of the vpc to install the ElasticSearch domain"
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
  type = bool
  description = "Determines if the cluster should provision dedicated cluster nodes."
  default = false
}

variable "es_dedicated_node_count" {
  type        = number
  description = "The number of dedicated nodes for the ElasticSearch Domain."
  default     = 1
}

variable "use_all_azs_in_region" {
  type = bool
  description = "Defaults to use all availabile Availability Zones in the Region. Takes prescendence over `es_az_count`."
  default = true
}

variable "es_az_aware" {
  type        = bool
  description = "Controls if the ElasticSeach domain should be AZ aware"
  default     = true
}

variable "es_az_count" {
  type = number
  description = "The number of AZ's to use in theElasticSearch domain cluster. Not applied if `use_all_azs_in_region` is `true`."
  default = 1
}

variable "es_encryption_enabled" {
  type = bool
  description = "Enables encryption (at rest) for data in theElasticSearch domain. Requires `kms_key` or `kms_key_auto_create` variables"
  default = true
}

variable "es_encryption_kms_key_id" {
  type = string
  description = "The KMS key ID used to encrypt theElasticSearch domain data. Ignored if `kms_key_auto_create` is true"
  default = null
}

variable "kms_key_auto_create" {
  type = bool
  description = "Controls if a KMS key resource is created within this module. Requires `es_encryption_enabled` to be true and takes precidence over `es_encryption_kms_key_id` variable"
  default = true
}

variable "es_advanced_options" {
  type        = map(any)
  description = "Advanced configuration options in JSON format"
  default     = null
}

variable "tags" {
  type = map(any)
  description = "Tags to apply to all resources"
  default = {}
}