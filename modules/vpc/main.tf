resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "lambda-vpc-${var.environment}"
  }
}

resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "lambda-subnet-${var.environment}"
  }
}

resource "aws_security_group" "this" {
  name        = "lambda-sg-${var.environment}"
  description = "Security group for Lambda in VPC"
  vpc_id      = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda-sg-${var.environment}"
  }
}
