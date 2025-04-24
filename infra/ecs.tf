resource "aws_ecs_cluster" "frontend_cluster" {
  name = "spacex-frontend-cluster"

  tags = {
    Name        = "spacex-frontend-cluster"
    Environment = "dev"
  }
}
