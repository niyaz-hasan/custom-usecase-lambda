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

variable "environment_variables" {
}

