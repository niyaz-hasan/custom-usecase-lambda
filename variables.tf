variable "lambda_environment_variables" {
  description = "Environment variables for the Lambda function"
  default     = {
    LOG_LEVEL = "INFO"
  }
}

variable "aws_region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}
