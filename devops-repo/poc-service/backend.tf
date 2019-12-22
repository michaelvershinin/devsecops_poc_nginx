terraform {
  backend "s3" {
    bucket = "devops-userdata"
    key    = "infra/service-poc.tf"
    region = "us-east-1"
  }
}
