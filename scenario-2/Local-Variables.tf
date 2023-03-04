# Define Local Values in Terraform
locals {
  owners      = var.business_divsion
  environment = var.environment

  name   = "${var.business_divsion}-${var.environment}"
  region = var.REGION

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}


