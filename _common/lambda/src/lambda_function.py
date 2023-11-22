import boto3
import botocore
import logging
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)
logger.info("Loading function")

s3 = boto3.resource("s3")


def lambda_handler(event, _):
    logger.info("New files uploaded to the source bucket.")

    key = event["Records"][0]["s3"]["object"]["key"]
    source_bucket = event["Records"][0]["s3"]["bucket"]["name"]

    source = {"Bucket": source_bucket, "Key": key}

    try:
        target_bucket = os.environ["TARGET_BUCKET"]
    except Exception as e:
        logger.error("Error fetching environment variable 'TARGET_BUCKET'")
        print(e)
        raise (e)

    try:
        s3.meta.client.copy(source, target_bucket, key)
        logger.info("File copied to the destination bucket successfully!")

    except botocore.exceptions.ClientError as e:
        logger.error("There was an error copying the file to the destination bucket")
        print(e)
        raise (e)

    except botocore.exceptions.ParamValidationError as e:
        logger.error("Missing required parameters while calling the API.")
        print(e)
        raise (e)
