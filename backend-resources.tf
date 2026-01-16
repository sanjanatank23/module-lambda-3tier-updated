
############################
# Random suffix for S3 bucket
############################
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

############################
# S3 Bucket for Terraform State
############################
resource "aws_s3_bucket" "terraform_state" {
  bucket = "sanjana-terraform-state-${random_id.bucket_suffix.hex}"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "terraform-state-bucket"
  }
}

############################
# Enable Versioning
############################
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

############################
# Enable Encryption
############################
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

############################
# DynamoDB Table for State Locking
############################
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-lock-table"
  }
}