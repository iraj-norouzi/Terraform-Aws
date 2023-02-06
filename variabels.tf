variable "EC2_DEPLOYMENTS" {
  type = map(any)
  default = {
    "web" = {
      "AWS_REGION"    = "us-east-1"
      "INSTANCE_TYPE" = "t2.micro"
    },
    "app" = {
      "AWS_REGION"    = "us-east-1"
      "INSTANCE_TYPE" = "t2.micro"
    }
  }
}
variable "AMIS" {
  description = "Ami in diffrente Region"
  type        = map(string)
  default = {
    "us-east-1" = "ami-0aa7d40eeae50c9a9"
    "us-east-2" = "ami-05bfbece1ed5beb54"
    # .
    # .
    # .

  }

}

variable "PATH_TO_PRIVATE_KEY" {}
variable "INSTANCE_USERNAME" {}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "PUBLIC_KEY" {}
