variable "bucket_name" {
  description = "Base name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/qa/prod)"
  type        = string
}
