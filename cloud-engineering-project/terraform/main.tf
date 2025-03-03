provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "csv_bucket" {
  bucket = "csv-upload-bucket"
}

resource "aws_dynamodb_table" "csv_metadata" {
  name         = "CSVMetadata"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "file_name"

  attribute {
    name = "file_name"
    type = "S"
  }
}

resource "aws_lambda_function" "csv_processor" {
  function_name = "CSVProcessor"
  filename      = "lambda.zip"
  handler       = "handler.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.csv_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.csv_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }
}
