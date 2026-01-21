data "aws_vpc" "this" {
  id = var.existing_vpc_id
}

resource "aws_subnet" "this" {
  vpc_id                  = data.aws_vpc.this.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "lambda-subnet-${var.environment}"
  }
}

resource "aws_security_group" "this" {
  name        = "lambda-sg-${var.environment}"
  description = "Security group for Lambda in VPC"
  vpc_id      = data.aws_vpc.this.id

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
