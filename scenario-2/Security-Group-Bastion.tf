module "bastion_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  # insert the 2 required variables here
  name        = "bastion-security-group"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags

}
