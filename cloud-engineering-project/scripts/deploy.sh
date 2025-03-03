#!/bin/bash
zip -r lambda.zip lambda/
aws s3 cp lambda.zip s3://csv-upload-bucket/
terraform apply -auto-approve
