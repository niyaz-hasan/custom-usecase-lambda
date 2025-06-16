module "iam" {
  source = "./modules/iam"
  name   = "ec2_scheduler_lambda"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function/ec2_control.py"
  output_path = "${path.module}/lambda_function/ec2_control.zip"
}

module "lambda_stop" {
  source         = "./modules/lambda"
  lambda_zip     = data.archive_file.lambda_zip.output_path
  function_name  = "ec2-stop-lambda"
  handler        = "ec2_control.lambda_handler"
  role_arn       = module.iam.role_arn
  instance_ids   = var.ec2_instance_ids
  ec2_action     = "stop"
}

module "lambda_start" {
  source         = "./modules/lambda"
  lambda_zip     = data.archive_file.lambda_zip.output_path
  function_name  = "ec2-start-lambda"
  handler        = "ec2_control.lambda_handler"
  role_arn       = module.iam.role_arn
  instance_ids   = var.ec2_instance_ids
  ec2_action     = "start"
}

module "stop_schedule" {
  source          = "./modules/eventbridge"
  name            = "stop-ec2-schedule"
#  cron_expression = "cron(0 17 ? * MON-FRI *)" # 5 PM 
  cron_expression = "cron(0/2 * * * ? *)"  
  lambda_arn      = module.lambda_stop.this.arn
  lambda_name     = module.lambda_stop.this.function_name
}

module "start_schedule" {
  source          = "./modules/eventbridge"
  name            = "start-ec2-schedule"
#  cron_expression = "cron(0 8 ? * MON-FRI *)" # 8 AM
  cron_expression = "cron(0/3 * * * ? *)"   
  lambda_arn      = module.lambda_start.this.arn
  lambda_name     = module.lambda_start.this.function_name
}


output "start_lambda_function_name" {
  value = module.lambda_start.this.function_name
}

output "stop_lambda_function_name" {
  value = module.lambda_stop.this.function_name
}

output "start_event_rule" {
  value = module.start_schedule.event_rule_name
}

output "stop_event_rule" {
  value = module.stop_schedule.event_rule_name
}
