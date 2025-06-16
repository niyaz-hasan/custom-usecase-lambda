import boto3
import os

region = os.environ['AWS_REGION']
ec2 = boto3.client('ec2', region_name=region)
action = os.environ['EC2_ACTION']
instance_ids = os.environ['INSTANCE_IDS'].split(',')

def lambda_handler(event, context):
    if action == 'start':
        ec2.start_instances(InstanceIds=instance_ids)
    elif action == 'stop':
        ec2.stop_instances(InstanceIds=instance_ids)
