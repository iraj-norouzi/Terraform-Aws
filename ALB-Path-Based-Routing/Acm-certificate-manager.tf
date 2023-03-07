module "acm" {
  source      = "terraform-aws-modules/acm/aws"
  version     = "4.3.2"
  domain_name = trimsuffix(data.aws_route53_zone.selected.name, ".")
  zone_id     = data.aws_route53_zone.selected.zone_id

  subject_alternative_names = [
    "*.fanapcdn.ir"
  ]

  wait_for_validation = true

}

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}
