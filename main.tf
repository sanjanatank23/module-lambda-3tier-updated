
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  environment       = var.environment
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  environment = var.environment
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
}

module "lambda" {
  source = "./modules/lambda"

  bucket_name        = module.s3.bucket_name
  subnet_id          = module.vpc.subnet_id
  security_group_id  = module.vpc.security_group_id
  lambda_role_arn    = module.iam.lambda_role_arn
  environment        = var.environment
}
