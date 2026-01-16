data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_code"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_s3_object" "lambda_zip" {
  bucket = var.bucket_name
  key    = "lambda-${var.environment}-${data.archive_file.lambda_zip.output_base64sha256}.zip"
  source = data.archive_file.lambda_zip.output_path
  etag   = filemd5(data.archive_file.lambda_zip.output_path)
}

resource "aws_lambda_function" "this" {
  function_name = "hello-world-lambda-${var.environment}"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  s3_bucket = var.bucket_name
  s3_key    = aws_s3_object.lambda_zip.key

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  vpc_config {
    subnet_ids         = [var.subnet_id]
    security_group_ids = [var.security_group_id]
  }
}
