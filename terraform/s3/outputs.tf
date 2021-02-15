# Bucket
output "bucket_website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}

output "bucket_domain_name" {
  value = aws_s3_bucket.bucket.bucket_domain_name
}