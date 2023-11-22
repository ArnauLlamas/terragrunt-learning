terraform {
  source = "${get_repo_root()}/_common/modules//s3_notification"
}

dependency "origin_bucket" {
  config_path = "../01-origin-bucket"

  mock_outputs = {
    s3_bucket_id = "mocked-origin-s3-bucket"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

dependency "lambda" {
  config_path = "../04-lambda"

  mock_outputs = {
    lambda_function_arn = "arn:aws:lambda:eu-west-1:123456789012:function:mocked-lambda"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  bucket              = dependency.origin_bucket.outputs.s3_bucket_id
  lambda_function_arn = dependency.lambda.outputs.lambda_function_arn
}
