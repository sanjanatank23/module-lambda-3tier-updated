#vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "3tier-vpc"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

#oublic subnet
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
}

#private subnet
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = "ap-south-1b"
}

#router table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}
#internet route
resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#router table association
resource "aws_route_table_association" "public_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#ec2 instance 
resource "aws_instance" "web" {
  ami                    = "ami-0ced6a024bb18ff2e"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

   user_data = <<-EOF
   #!/bin/bash
   yum update -y
   yum install -y httpd
   systemctl start httpd
   systemctl enable httpd
   echo "<h1>Hello from Terraform</h1>" > /var/www/html/index.html
   EOF

  tags = {
    Name = "WebServer"
  }
}

#Storage Tier (S3)
resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-3tier-${random_id.rand.hex}"
}

resource "random_id" "rand" {
  byte_length = 4
}



resource "aws_s3_bucket_server_side_encryption_configuration" "enc" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}