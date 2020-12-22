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

variable "region" {
  type    = string
  default = "ap-southeast-2"
}