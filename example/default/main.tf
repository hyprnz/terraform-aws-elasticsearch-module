# Used to provision the ServiceLink Role before the module
resource "aws_iam_service_linked_role" "this" {
  count            = 0
  aws_service_name = "es.amazonaws.com"
  description      = "AWSServiceRoleForAmazonElasticsearchService Service-Linked Role"
}

module "example" {
  source = "../../"
  providers = {
    aws = aws
  }

  enabled                        = true
  es_domain                      = var.es_domain
  es_vpc_id                      = var.es_vpc_id
  es_subnet_ids                  = var.es_subnet_ids
  allowed_cdir_blocks            = var.allowed_cdir_blocks
  es_dedicated_node_enabled      = true
  es_dedicated_node_count        = 3
  es_ebs_volume_size             = 100
  iam_actions                    = ["es:*"]
  iam_role_arns                  = var.iam_role_arns
  security_groups_ingress_source = var.security_groups_ingress_source
  es_master_user_arn             = var.es_master_user_arn
}

provider "aws" {
  region = var.region
}