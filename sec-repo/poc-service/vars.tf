# COMMON
variable aws_region {
  description          = "aws region for tf provider settings"
  default              = "us-east-1"
}

variable "environment" {
  description          = "Environment name (production|dev|test|staging)"
  type                 = string
  default              = "dev"
}

variable "service_name" {
  description          = "service name"
  default              = "poc-service"
}

# SECURITY
variable "vpc_id" {}

variable "public_sg_name" {}
variable "public_sg_allow_ports_rules" {
  type = list(object(
    {
      description      = string
      from_port        = string
      to_port          = string
      protocol         = string
      cidr_blocks      = list(string)
    }
  ))
}

variable "private_sg_name" {}
variable "private_sg_allow_ports_rules" {
  type                 = list(object(
    {
      description      = string
      from_port        = string
      to_port          = string
      protocol         = string
      cidr_blocks      = list(string)
    }
  ))
}
