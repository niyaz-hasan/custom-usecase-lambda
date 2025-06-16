variable "name" {
  description = "EventBridge rule name"
  type        = string
}

variable "cron_expression" {
  description = "Cron schedule expression"
  type        = string
}

variable "lambda_arn" {
  description = "Lambda function ARN to trigger"
  type        = string
}

variable "lambda_name" {
  description = "Lambda function name"
  type        = string
}
