output "s3_bucket_id" {
  description = "The S3 bucket ID"
  value       = aws_s3_bucket.intuitive-s3.id

}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.intuitive-s3.arn
}