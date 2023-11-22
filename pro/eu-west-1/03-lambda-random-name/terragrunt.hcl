include "root" {
  path = "${get_repo_root()}/_common/root.hcl"
}

include "random_name_generator" {
  path = "${get_repo_root()}/_common/random_name_generator.hcl"
}
