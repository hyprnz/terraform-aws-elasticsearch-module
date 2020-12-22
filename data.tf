data "aws_vpc" "this" {
  count = var.enabled ? 1 : 0

  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet_ids" "this" {
  count = var.enabled ? 1 : 0

  vpc_id = data.aws_vpc.this[0].id

  tags = {
    Tier = "Private"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "this" {}

data "aws_region" "this" {}