# Cloud Engineering Project

## Overview
This project automates CSV file processing using AWS services like S3, Lambda, and DynamoDB.

## Components
- **Lambda Function:** Processes CSV files.
- **S3 Bucket:** Stores uploaded files.
- **DynamoDB:** Stores metadata.

## Deployment Steps
1. Install AWS CLI & Terraform.
2. Run `terraform apply` to set up infrastructure.
3. Deploy Lambda with `scripts/deploy.sh`.

## Future Enhancements
- Add API Gateway for external access.
- Implement logging with CloudWatch.
