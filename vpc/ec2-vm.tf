locals {
  multiple_instances = {
    one = {
      instance_type     = "t2.micro"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
    }
    two = {
      instance_type     = "t2.micro"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.private_subnets, 1)
    }
  }
}

module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  depends_on             = [module.vpc, aws_key_pair.IRAJ_KEY]
  for_each               = local.multiple_instances
  name                   = "${local.name}-multi-${each.key}"
  instance_type          = each.value.instance_type
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [module.private_security_group.security_group_id]
  tags                   = local.common_tags
  ami                    = data.aws_ami.amzlinux2.id
  key_name               = aws_key_pair.IRAJ_KEY.key_name
  user_data              = file("${path.module}/app1-install.sh")



}














# module "ec2_instance_bastion" {
#   depends_on = [module.vpc, aws_key_pair.IRAJ_KEY]
#   source     = "terraform-aws-modules/ec2-instance/aws"
#   version    = "4.3.0"
#   # AWS EC2 Instance Terraform Module
#   # Bastion Host - EC2 Instance that will be created in VPC Public Subnet
#   name = "${var.environment}-BastionHost"
#   #   instance_count = 2
#   ami           = data.aws_ami.amzlinux2.id
#   instance_type = var.instance_type
#   key_name      = aws_key_pair.IRAJ_KEY.key_name

#   #monitoring             = true
#   subnet_id              = module.vpc.public_subnets[0]
#   vpc_security_group_ids = [module.bastion_security_group.security_group_id]
#   tags                   = local.common_tags


# }












# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets
# module "ec2_private" {
#   depends_on = [module.vpc, aws_key_pair.IRAJ_KEY] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
#   source     = "terraform-aws-modules/ec2-instance/aws"
#   version    = "4.3.0"
#   # insert the 10 required variables here
#   name          = "${var.environment}-vm"
#   ami           = data.aws_ami.amzlinux2.id
#   instance_type = var.instance_type
#   key_name      = aws_key_pair.IRAJ_KEY.key_name
#   #monitoring             = true
#   vpc_security_group_ids = [module.bastion_security_group.security_group_id]
#   subnet_id              = module.vpc.private_subnets[0]
#   # subnet_id = [
#   #   module.vpc.private_subnets[0],
#   #   module.vpc.private_subnets[1]
#   # ]
#   # # instance_count = 2
#   user_data = file("${path.module}/app1-install.sh")
#   tags      = local.common_tags
# }


