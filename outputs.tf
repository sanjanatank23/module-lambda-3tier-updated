output "lambda_name" {
  value = aws_lambda_function.lambda.function_name
}

output "vpc_id" {
  value = aws_vpc.lambda_vpc.id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}





#terraform-3tier/
#│
#├── main.tf        👈 ALL resources go here
#├── variables.tf   👈 variables only
#├── outputs.tf     👈 outputs only
#├── provider.tf   👈 provider only
#├── README.md