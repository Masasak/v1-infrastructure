resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = var.is_scan_on_push
  }
}