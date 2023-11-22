locals {
  team    = "a-team"
  project = "learning-terragrunt"
  service = "remote-modules"

  # This is used for the highest S3 key to store the Terraform state
  # Is is usually safer to use a "hardcoded/specified" string to ensure
  # it survives both project and team names (these can actually change!)
  project_key = "learning-terragrunt-remote-modules"
}
