# ===============================================================================================================
data "aws_caller_identity" "current" {}

resource "aws_iam_instance_profile" "iamip" {
  name = "${var.environment}-iam-${var.service_name}-role"
  path = "/"
  role = "${var.environment}-iam-${var.service_name}-role"
}
# ===============================================================================================================

resource "aws_iam_role" "iam_role" {
  name               = "${var.environment}-iam-${var.service_name}-role"
  path               = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.environment}-iam-${var.service_name}-role"
    Env = var.environment
    Managed_by = "Terraform"
    Owner = "Security"
  }
  force_detach_policies = true
}
# ===============================================================================================================

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  count = length(var.include_policy)
  role = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.include_policy[count.index]}"
}
# ===============================================================================================================
