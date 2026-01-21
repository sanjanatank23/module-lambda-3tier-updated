variable "region" {
  type    = string
  default = "ap-south-1"
}


variable "environment" {
  type = string
}

# variable "vpc_cidr" {
#   type = string
# }

variable "subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "existing_vpc_id" {
  type = string
}
