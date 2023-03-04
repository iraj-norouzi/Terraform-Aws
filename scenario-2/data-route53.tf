data "aws_route53_zone" "selected" {
  name = "fanapcdn.ir."
}

output "mydomain_zone_id" {
  description = "my zone ID "
  value       = data.aws_route53_zone.selected.zone_id

}

output "mydomain_name" {
  description = "my zone Name "
  value       = data.aws_route53_zone.selected.name

}
