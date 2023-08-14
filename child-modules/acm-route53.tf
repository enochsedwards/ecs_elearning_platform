# Get hosted zone details
data "aws_route53_zone" "sel-hosted-zone" {
    name = "skillsedgelab.com"
}


# create a record set in route 53
resource "aws_route53_record" "site-domain-record" {
    zone_id = data.aws_route53_zone.sel-hosted-zone.zone_id
    name    = "${data.aws_route53_zone.sel-hosted-zone.name}"
    type    = "A"

    alias {
    name                   = aws_lb.SEL-lb.dns_name
    zone_id                = aws_lb.SEL-lb.zone_id
    evaluate_target_health = true
    }
}

# Request certificate from the Amazon Certificate Manager
resource "aws_acm_certificate" "sel-certificate" {
  domain_name       = var.domain_name
  subject_alternative_names = var.alternative_name
  validation_method = "DNS"
}

# Create DNS Validation with Route 53
resource "aws_route53_record" "sel-record" {
  for_each = {
    for dvo in aws_acm_certificate.sel-certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.sel-hosted-zone.zone_id
}



resource "aws_acm_certificate_validation" "sel-certificate-validation" {
  certificate_arn         = aws_acm_certificate.sel-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.sel-record : record.fqdn]
}