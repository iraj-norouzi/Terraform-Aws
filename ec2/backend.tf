terraform {
  backend "s3" {
    bucket = "terraform-state-iraj"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
