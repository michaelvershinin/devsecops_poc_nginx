# COMMON
environment                       = "dev"

subnet_id                         = "subnet-xxxxxxxxx"
private_security_group_names      = [ "dev-poc-service-private-sg" ]
public_security_group_names       = [ "dev-poc-service-public-sg" ]

include_policy                    = [ "poc-service-policy" ]
aws_key                           = "key"
bucket_name                       = "poc-bucket"
zone_id                           = "xxxxxxxxxxxxxx"
