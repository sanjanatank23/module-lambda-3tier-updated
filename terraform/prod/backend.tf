terraform {
  backend "s3" {
    bucket         = "sanjana-terraform-state"
    key            = "lambda/prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
