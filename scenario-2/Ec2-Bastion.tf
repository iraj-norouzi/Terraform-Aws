module "ec2_instance_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"
  # AWS EC2 Instance Terraform Module
  # Bastion Host - EC2 Instance that will be created in VPC Public Subnet
  name                   = "${var.environment}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.IRAJ_KEY.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion_security_group.security_group_id]
  tags                   = local.common_tags


}
