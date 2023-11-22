variable "bucket" {
  type        = string
  description = "S3 bucket name that will emit notifications on objects created"
}

variable "lambda_function_arn" {
  type        = string
  description = "Lambda function ARN that will receive the notifications"
}

resource "aws_s3_bucket_notification" "this" {
  bucket = var.bucket
  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }
}
