# define provider
provider "aws" {
  region = var.aws_region
}

# create bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = file("../../files/policy.json")

  versioning {
    enabled = false
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
  tags = var.tags
}

# Upload an object
resource "aws_s3_bucket_object" "object" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "../../files/index.html"
  etag         = filemd5("../../files/index.html")
  acl          = "public-read"
  content_type = "text/html"

}