# AWS Lambda in VPC using Terraform (S3 Backend)

This project demonstrates how to use **Terraform** to provision an **AWS Lambda function inside a VPC**, package and upload Python code to **Amazon S3**, and configure **remote state storage using an S3 backend with DynamoDB locking**.

The setup ensures infrastructure is fully reproducible and follows Terraform best practices.

---

## 📌 Architecture Overview

- AWS VPC created using Terraform
- Dedicated subnet for Lambda function
- Lambda function deployed inside the VPC
- Python Lambda code packaged as a ZIP using Terraform
- ZIP file uploaded to Amazon S3
- Lambda function uses code from S3
- Terraform remote backend:
  - State stored in S3
  - State locking using DynamoDB

---

## 🗂 Project Structure

lambda-vpc-terraform/
├── backend.tf
├── provider.tf
├── vpc.tf
├── lambda.tf
├── s3.tf
├── iam.tf
├── outputs.tf
├── .gitignore
│
├── lambda_code/
│ └── lambda_function.py
│
└── README.md
---

## 🛠 Prerequisites

- AWS account
- IAM user with sufficient permissions
- AWS CLI installed and configured
- Terraform installed (v1.x recommended)
- Git & GitHub account
- WSL (Ubuntu) or Linux/macOS terminal

---

## ⚙️ AWS Backend Setup (One-Time)

Terraform cannot create its own backend resources.  
Create these **before running `terraform init`**:

### S3 bucket for Terraform state
```bash
aws s3api create-bucket \
  --bucket <your-terraform-state-bucket> \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

