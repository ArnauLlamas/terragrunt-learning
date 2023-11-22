locals {
  app_vars    = read_terragrunt_config("${get_repo_root()}/_common/app.hcl")
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  aws_default_tags = jsonencode({
    environment = local.env_vars.locals.environment
    team        = local.app_vars.locals.team
    project     = local.app_vars.locals.project
    service     = local.app_vars.locals.service
    iac         = "terragrunt"
    repo        = trimsuffix(run_cmd("--terragrunt-quiet", "git", "config", "--get", "remote.origin.url"), ".git")
  })
}

# Generate an AWS provider block for the current Region and AWS Account
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
      region = "${local.region_vars.locals.aws_region}"
    
      # Allow Terraform code to only be ran on these AWS Account IDs
      # allowed_account_ids = ["${local.env_vars.locals.aws_account_id}"]
    
      default_tags {
        tags = jsondecode(
          <<-INNEREOF
            ${local.aws_default_tags}
          INNEREOF
        )
      }
    }
  EOF
}

# remote_state {
#   backend = "s3"
#   config = {
#     disable_bucket_update = true
#     encrypt               = true
#     bucket                = "${local.env_vars.locals.tf_bucket_name}"
#     key                   = "${local.app_vars.locals.project_key}/ ${local.region_vars.locals.aws_region}/ ${trim(basename(path_relative_to_include()), "-0123456789")}/terraform.tfstate"
#     region                = "eu-west-1"
#   }
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
# }
