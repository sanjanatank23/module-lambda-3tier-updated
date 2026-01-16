resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name}-${var.environment}"

  tags = {
    Name        = "lambda-code-bucket-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}
