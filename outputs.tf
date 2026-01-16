output "lambda_name" {
  value = module.lambda.lambda_function_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "lambda_role_arn" {
  value = module.iam.lambda_role_arn
}
