resource "aws_cloudwatch_event_rule" "schedule" {
  name                = var.name
  schedule_expression = var.cron_expression
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.schedule.name
  target_id = "lambda-target"
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "allow_event" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule.arn
}

output "event_rule_name" {
  description = "CloudWatch Event Rule name"
  value       = aws_cloudwatch_event_rule.schedule.name
}
