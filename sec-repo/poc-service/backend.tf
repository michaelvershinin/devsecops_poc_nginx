terraform {
  backend "s3" {
    bucket = "devops-userdata"
    key    = "security/service-poc.tf"
    region = "us-east-1"
  }
}
