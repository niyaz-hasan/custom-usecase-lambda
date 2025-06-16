variable "lambda_zip" {
  description = "Path to the Lambda deployment zip file"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda handler"
  type        = string
  default     = "ec2_control.lambda_handler"
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "role_arn" {
  description = "IAM role ARN for the Lambda function"
  type        = string
}

variable "instance_ids" {
  description = "Comma-separated EC2 instance IDs"
  type        = string
}

variable "ec2_action" {
  description = "Action to perform: start or stop"
  type        = string
}
