output "security_group_bastion_arn" {
  description = "The ARN of the security group"
  value       = module.bastion_security_group.security_group_arn
}

output "security_group_bastion_id" {
  description = "The ID of the security group"
  value       = module.bastion_security_group.security_group_id
}

output "security_group_bastion_vpc_id" {
  description = "The VPC ID"
  value       = module.bastion_security_group.security_group_vpc_id
}

output "security_group_bastion_owner_id" {
  description = "The owner ID"
  value       = module.bastion_security_group.security_group_owner_id
}

output "security_group_bastion_name" {
  description = "The name of the security group"
  value       = module.bastion_security_group.security_group_name
}

output "security_group_bastion_description" {
  description = "The description of the security group"
  value       = module.bastion_security_group.security_group_description
}

output "basttion_host_PUBLIC_IP" {
  description = "The description of the security group"
  value       = aws_eip.bastion_eip.public_ip

}
