module "example" {
  source = "../../"
  providers = {
    aws = aws
  }

  enabled = false

}

provider "aws" {
  region = var.region
}