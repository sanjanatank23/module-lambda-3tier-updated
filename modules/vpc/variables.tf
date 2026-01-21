variable "existing_vpc_id" {
  description = "Existing VPC ID where resources will be created"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
