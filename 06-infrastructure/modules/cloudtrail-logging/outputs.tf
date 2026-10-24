output "trail_name" {
  value = aws_cloudtrail.this.name
}

output "log_bucket" {
  value = module.log_bucket.bucket_id
}