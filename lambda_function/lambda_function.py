import json
import boto3
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Initialize EC2 client
ec2 = boto3.client('ec2')

def handler(event, context):
    try:
        # Describe all volumes
        response = ec2.describe_volumes()
        
        # Loop through each volume and check if it's unattached
        for volume in response['Volumes']:
            if not volume['Attachments']:
                # If the volume has no attachments, delete it
                volume_id = volume['VolumeId']
                logger.info(f"Deleting unattached volume: {volume_id}")
                ec2.delete_volume(VolumeId=volume_id)

        return {
            'statusCode': 200,
            'body': json.dumps('Unused EBS volumes cleaned up successfully.')
        }

    except Exception as e:
        logger.error(f"Error cleaning up unused EBS volumes: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }
