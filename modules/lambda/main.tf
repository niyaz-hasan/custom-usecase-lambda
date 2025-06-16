resource "aws_lambda_function" "this" {
  filename         = var.lambda_zip
  function_name    = var.function_name
  handler          = var.handler
  runtime          = "python3.12"
  role             = var.role_arn
  timeout          = 30
  source_code_hash = filebase64sha256(var.lambda_zip)

  environment {
    variables = var.environment_variables
  }
}

output "this" {
  description = "Lambda function resource"
  value       = aws_lambda_function.this
}
