module "example" {
  source = "../../"
  providers = {
    aws = aws
  }

  enabled = true
  es_domain = var.es_domain
  vpc_name = var.vpc_name
  es_dedicated_node_enabled = true

}

provider "aws" {
  region = var.region
}