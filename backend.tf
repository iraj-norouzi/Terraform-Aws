terraform {
  backend "s3" {
    bucket = "terraform-state-iraj"
    key    = "terraform/terraform.tfstate"
    # key            = "jhooq/terraform/remote/s3/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "dynamodb-state-locking"
  }
}
