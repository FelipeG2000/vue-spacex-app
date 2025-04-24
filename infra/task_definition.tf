resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "spacex-frontend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "spacex-frontend"
      image     = "${aws_ecr_repository.frontend_repo.repository_url}:latest"
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      essential = true
    }
  ])
}
