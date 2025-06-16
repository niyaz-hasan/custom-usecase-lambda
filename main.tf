module "iam" {
  source = "./modules/iam"
  name   = "unused_ebs_lambda"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function/lambda_function.py"
  output_path = "${path.module}/lambda_function/lambda_function.zip"
}



module "lambda" {
  source         = "./modules/lambda"
  lambda_zip     = data.archive_file.lambda_zip.output_path
  function_name  = "unused-ebs-cleanup"
  handler        = "lambda_function.lambda_handler"
  role_arn       = module.iam.role_arn
  environment_variables = var.lambda_environment_variables
}


module "cloudwatch_events" {
  source          = "./modules/eventbridge"
  name            = "unused-ebs-cleanup-rule"
#  cron_expression = "cron(0 8 ? * MON-FRI *)" # 8 AM
  cron_expression = "rate(24 hours)"   # This would trigger the event every 24 hours 
  lambda_arn      = module.lambda.this.arn
  lambda_name     = module.lambda.this.function_name
}


output "start_lambda_function_name" {
  value = module.lambda.this.function_name
}

output "cloudwatch_events_name" {
  value = module.cloudwatch_events.event_rule_name
}


