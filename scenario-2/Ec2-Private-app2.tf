locals {
  app2_instances = {
    App2-A = {
      instance_type     = "t2.micro"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
    }
    App2-B = {
      instance_type     = "t2.micro"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.private_subnets, 1)
    }
  }
}

module "ec2_private_app2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  depends_on             = [module.vpc, aws_key_pair.IRAJ_KEY]
  for_each               = local.app2_instances
  name                   = "${local.name}-multi-${each.key}"
  instance_type          = each.value.instance_type
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [module.private_security_group.security_group_id]
  tags                   = local.common_tags
  ami                    = data.aws_ami.amzlinux2.id
  key_name               = aws_key_pair.IRAJ_KEY.key_name
  user_data              = file("${path.module}/app2-install.sh")



}
