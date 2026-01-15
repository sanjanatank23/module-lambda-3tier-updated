terraform {
  backend "s3" {
    bucket         = "sanjana-terraform-state-bucket"
    key            = "lambda/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
