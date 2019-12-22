aws_region = "us-east-1"
environment = "dev"
vpc_id = "vpc-xxxxxxx"

public_sg_name = "dev-poc-service-public-sg"
public_sg_allow_ports_rules = [
  {
    description = "allow-http"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = [
      "x.x.x.x/32",
      "x.x.0.0/16"
    ]
  },
  {
    description = "allow-ssh"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = [
      "x.x.x.x/32",
      "x.x.0.0/16"
    ]
  }
]

private_sg_name = "dev-poc-service-private-sg"
private_sg_allow_ports_rules = [{
    description = "allow in-vpc access"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "x.x.0.0/16"
    ]
  }
]
