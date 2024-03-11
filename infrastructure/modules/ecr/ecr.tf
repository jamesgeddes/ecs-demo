resource "aws_ecr_repository" "repo" {
  name                 = local.repo_full_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}