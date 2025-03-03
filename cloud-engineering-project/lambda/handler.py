import boto3
import pandas as pd
import json

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    file_key = event['Records'][0]['s3']['object']['key']

    obj = s3.get_object(Bucket=bucket, Key=file_key)
    df = pd.read_csv(obj['Body'])

    metadata = {
        'file_name': file_key,
        'column_count': len(df.columns),
        'row_count': len(df),
        'columns': list(df.columns),
    }

    table = dynamodb.Table("CSVMetadata")
    table.put_item(Item=metadata)

    return {'statusCode': 200, 'body': json.dumps("File processed!")}
