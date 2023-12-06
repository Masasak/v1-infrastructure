locals {
  ecr_name_prefix = "snapvibe"
  ecr_version1_prefix = "v1"
  ecr_names = [
    "image-service",
    "post-service",
    "comment-service",
    "user-service",
    "report-service",
    "attachment-service",
    "chat-service",
    "auth-service",
    "gateway"
  ]
}

locals {
  ecr_name = toset([
    for name in local.ecr_names : name
  ])
}

module "ecr" {
  source = "./modules/ecr"

  for_each = local.ecr_name
  name     = "${local.ecr_name_prefix}-${local.ecr_version1_prefix}-${each.value}"
}

output "ecr_url" {
  value = [
    for repo in module.ecr : repo.ecr_repository_url
  ]
}