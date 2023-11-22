terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-lambda?ref=v6.4.0"
}

dependency "origin_bucket" {
  config_path = "../01-origin-bucket"

  mock_outputs = {
    s3_bucket_arn = "arn:aws:s3:::mocked-origin-s3-bucket"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

dependency "target_bucket" {
  config_path = "../02-target-bucket"

  mock_outputs = {
    s3_bucket_arn = "arn:aws:s3:::mocked-destination-s3-bucket"
    s3_bucket_id  = "mocked-destination-s3-bucket"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

dependency "lambda_random_name" {
  config_path = "../03-lambda-random-name"

  mock_outputs = {
    random_id  = "abcde1452/"
    random_pet = "friendly-random-name"
  }
}

inputs = {
  function_name = dependency.lambda_random_name.outputs.random_pet

  handler = "lambda_function.lambda_handler"
  runtime = "python3.11"
  publish = true

  source_path = {
    path     = "${get_repo_root()}/_common/lambda/src",
    commands = [ ":zip" ]
  }

  environment_variables = {
    TARGET_BUCKET = dependency.target_bucket.outputs.s3_bucket_id
  }

  allowed_triggers = {
    OriginS3 = {
      principal = "s3.amazonaws.com"
      source_arn = dependency.origin_bucket.outputs.s3_bucket_arn
    }
  }

  attach_policy_json = true
  policy_json = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": "${dependency.origin_bucket.outputs.s3_bucket_arn}/*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:PutObject"
        ],
        "Resource": "${dependency.target_bucket.outputs.s3_bucket_arn}/*"
      }
    ]
  }
  EOF
}
