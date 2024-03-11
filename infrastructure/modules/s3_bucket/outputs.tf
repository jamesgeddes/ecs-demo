output "bucket_url" {
  value = "s3://${aws_s3_bucket.hyacinth_bucket.bucket}"
}

output "bucket_name" {
  value = aws_s3_bucket.hyacinth_bucket.bucket
}