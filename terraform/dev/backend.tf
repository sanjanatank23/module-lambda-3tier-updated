
terraform {
  backend "s3" {
    bucket         = "sanjana-terraform-state"
    key            = "lambda/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
