# COMMON
variable "environment" {
  description = "Environment name (prod|stg|dev)"
  type        = string
}
variable "service_name" {
  description = "service name"
  default     = "poc-service"
}

# EC2
variable "instance_type" {
  default = "t2.micro"
}

# SECURITY
variable "private_security_group_names" {
  type = list(string)
}
variable "public_security_group_names" {
  type = list(string)
}
variable "subnet_id" {}
variable "include_policy" {}
variable "aws_key" {}
variable "bucket_name" {}
variable "zone_id" {}
