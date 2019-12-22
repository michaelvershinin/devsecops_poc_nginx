# ============================================================================================
variable "bucket_name" {
  default = "poc-bucket"
}

resource "aws_s3_bucket" "bucket_poc" {
    bucket = var.bucket_name

    versioning {
        enabled = true
    }

    tags = {
        Name        = var.bucket_name
        Environment = var.environment
    }
    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["GET"]
        max_age_seconds = "3000"
        allowed_origins = ["*"]
    }
}
# ============================================================================================
# CRAETE FOLDERS
variable "s3_folders" {
    type        = list
    description = "The list of S3 folders to create"
    default     = ["files", "images"]
}
resource "aws_s3_bucket_object" "content" {
    count  = length(var.s3_folders)
    bucket = aws_s3_bucket.bucket_poc.id
    acl    = "private"
    key    = "${var.s3_folders[count.index]}/"
    source = "/dev/null"
}
# CREATE HTML FILE
variable "html_file_path" {
    description = "html file"
    default     = "files/index.html"
}
resource "aws_s3_bucket_object" "put_html_file" {
    key                    = "files/index.html"
    bucket                 = aws_s3_bucket.bucket_poc.id
    source                 = var.html_file_path
}

variable "user_data_path" {
    description = "user data"
    default     = "files/userdata.sh"
}
resource "aws_s3_bucket_object" "put_userdata" {
    key                    = "files/userdata.sh"
    bucket                 = aws_s3_bucket.bucket_poc.id
    source                 = var.user_data_path
    content_type           = "text/*"
}
# ============================================================================================
