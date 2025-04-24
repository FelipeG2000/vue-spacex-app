resource "aws_ecr_repository" "frontend_repo" {
  name                 = "spacex-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "spacex-frontend"
    Environment = "dev"
  }
}