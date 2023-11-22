include "root" {
  path = "${get_repo_root()}/_common/root.hcl"
}

include "s3_notifications" {
  path = "${get_repo_root()}/_common/s3_notifications.hcl"
}
