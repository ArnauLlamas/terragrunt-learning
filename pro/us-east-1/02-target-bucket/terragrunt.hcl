include "root" {
  path = "${get_repo_root()}/_common/root.hcl"
}

include "s3" {
  path = "${get_repo_root()}/_common/s3.hcl"
}
