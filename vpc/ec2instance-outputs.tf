# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_instance_bastion.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_instance_bastion.public_ip
}

# EC2 Multiple
output "ec2_instance_bastion" {
  description = "The full output of the `ec2_module` module"
  value       = module.ec2_instance_bastion
}
# EC2 Multiple
output "ec2_multiple" {
  description = "The full output of the `ec2_module` module"
  value       = module.ec2_private
}


# # Private EC2 Instances
# ## ec2_private_instance_ids
# output "ec2_private_instance_ids" {
#   description = "List of IDs of instances"
#   value       = module.ec2_private.id
# }
# ## ec2_private_ip
# output "ec2_private_ip" {
#   description = "List of private IP addresses assigned to the instances"
#   value       = module.ec2_private.private_ip
# }



