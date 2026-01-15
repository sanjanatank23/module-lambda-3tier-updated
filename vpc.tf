resource "aws_vpc" "lambda_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lambda-vpc"
  }
}

resource "aws_subnet" "lambda_subnet" {
  vpc_id            = aws_vpc.lambda_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "lambda-subnet"
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg"
  description = "Security group for Lambda in VPC"
  vpc_id      = aws_vpc.lambda_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda-sg"
  }
}
