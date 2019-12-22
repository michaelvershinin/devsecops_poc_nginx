# ============================================================================================
locals {
  name                        = format("%s-%s", var.environment, var.service_name)
  common_tags                 = {
    terraform                 = "true"
    environment               = var.environment
    service                   = var.service_name
  }
}
# ============================================================================================
data "aws_security_groups" "private_sg" {
  tags                        = local.common_tags
  filter {
    name                      = "group-name"
    values                    = [format("%s-private-sg", local.name)]
  }
}
# ============================================================================================
data "aws_security_groups" "public_sg" {
  tags                        = local.common_tags
  filter {
    name                      = "group-name"
    values                    = [format("%s-public-sg", local.name)]
  }
}
# ============================================================================================
data "aws_s3_bucket_object" "user_data_object" {
  bucket = var.bucket_name
  key    = "files/userdata.sh"
}

output "user_data_output" {
  value = data.aws_s3_bucket_object.user_data_object.body
}

data "template_file" "user_data" {
  template = data.aws_s3_bucket_object.user_data_object.body
  vars = {
    service_name              = var.service_name
    bucket_name               = var.bucket_name
  }
}

# ============================================================================================
data "aws_ami" "packer_ami" {
  owners = [ data.aws_caller_identity.current.account_id ]
  most_recent = true
  filter {
    name   = "tag:ami_name"
    values = [ var.service_name ]
  }
  filter {
    name   = "tag:environment"
    values = [ var.environment ]
  }
}

# ============================================================================================
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.packer_ami.id
  instance_type               = var.instance_type
  key_name                    = var.aws_key
  subnet_id                   = var.subnet_id
  iam_instance_profile        = aws_iam_instance_profile.iamip.id
  vpc_security_group_ids      = data.aws_security_groups.public_sg.ids
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered
  tags                        = merge(
    { "Name"                  = format("%s", local.name) }, local.common_tags
  )
}
# ============================================================================================

