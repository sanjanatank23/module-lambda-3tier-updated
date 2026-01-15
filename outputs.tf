output "lambda_name" {
  value = aws_lambda_function.lambda.function_name
}

output "vpc_id" {
  value = aws_vpc.lambda_vpc.id
}
