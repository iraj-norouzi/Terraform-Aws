provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  # region     = "eu-east-1"
}

module "sample" {
  source              = "./modules"
  AWS_ACCESS_KEY      = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY      = var.AWS_SECRET_KEY
  PUBLIC_KEY          = var.PUBLIC_KEY
  INSTANCE_USERNAME   = var.INSTANCE_USERNAME
  PATH_TO_PRIVATE_KEY = var.PATH_TO_PRIVATE_KEY
  AMIS                = var.AMIS
  EC2_DEPLOYMENTS     = var.EC2_DEPLOYMENTS
  # REGIONS             = var.REGIONS

}
