variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, qa, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
}

variable "bucket_name" {
  description = "Base name for S3 bucket"
  type        = string
}
