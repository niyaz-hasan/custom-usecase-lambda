resource "aws_lambda_function" "this" {
  filename         = var.lambda_zip
  function_name    = var.function_name
  handler          = var.handler
  runtime          = "python3.12"
  role             = var.role_arn
  timeout          = 30
  source_code_hash = filebase64sha256(var.lambda_zip)

  environment {
    variables = {
      INSTANCE_IDS = var.instance_ids
      EC2_ACTION   = var.ec2_action
    }
  }
}

output "this" {
  description = "Lambda function resource"
  value       = aws_lambda_function.this
}
