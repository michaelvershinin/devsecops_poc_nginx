resource "aws_route53_record" "poc_service" {
    zone_id = var.zone_id
    name    = "${var.service_name}-dev.poc.com"
    type    = "CNAME"
    ttl     = "300"
    records = [ aws_instance.ec2_instance.public_ip ]
}
