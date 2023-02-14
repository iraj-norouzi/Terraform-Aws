# Define Local Values in Terraform
locals {
  # name   = "ex-${replace(basename(path.cwd), "_", "-")}"
  owners      = var.business_divsion
  environment = var.environment

  name   = "${var.business_divsion}-${var.environment}"
  region = var.REGION

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}


