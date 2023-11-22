include "root" {
  path = "${get_repo_root()}/_common/root.hcl"
}

include "lambda" {
  path = "${get_repo_root()}/_common/lambda.hcl"
}

include "patch" {
  path = "./patch.hcl"
}

# inputs = {
#   function_name = "just-a-custom-name"
# }
