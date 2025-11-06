terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "random_id" "rand-id" {
  byte_length = 8
}

resource "aws_s3_bucket" "myweb-app-bucket" {
  bucket = "myweb-app-bucket-${random_id.rand-id.hex}"
}



# removed restrictions from website on visiting of others

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.myweb-app-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# adding policy to make website accessable for all

resource "aws_s3_bucket_policy" "myweb-app" {
  bucket = aws_s3_bucket.myweb-app-bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject"
          Resource  = "arn:aws:s3:::${aws_s3_bucket.myweb-app-bucket.id}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "myweb-app" {
  bucket = aws_s3_bucket.myweb-app-bucket.id

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.myweb-app-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.myweb-app-bucket.bucket
  source       = "./style.css"
  key          = "style.css"
  content_type = "text/css"

}
output "name" {
  value = aws_s3_bucket_website_configuration.myweb-app.website_endpoint
}

