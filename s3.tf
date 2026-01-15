
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "sanjana-lambda-code-bucket"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.lambda_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

