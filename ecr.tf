locals {
  ecr_names = [
    "Image-Service",
    "Post-Service",
    "Comment-Service",
    "User-Service",
    "Report-Service",
    "Attachment-Service",
    "Chat-Service",
    "Auth-Service"
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
  name     = "${local.name_prefix}-${each.value}"
}

output "ecr_url" {
  value = [
    for repo in module.ecr : repo.ecr_repository_url
  ]
}