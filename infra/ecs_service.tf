resource "aws_ecs_service" "frontend_service" {
  name            = "spacex-frontend-service"
  cluster         = aws_ecs_cluster.frontend_cluster.id
  task_definition = aws_ecs_task_definition.frontend_task.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets          = [aws_subnet.frontend_subnet.id]
    security_groups  = [aws_security_group.frontend_sg.id]
    assign_public_ip = true
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "spacex-frontend"
    container_port   = 80
  }

  depends_on = [
    aws_lb_listener.frontend_listener
  ]
}

resource "aws_lb" "frontend_lb" {
  name               = "spacex-frontend-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.frontend_subnet.id, 
                        aws_subnet.frontend_subnet_b.id
                        ]
  security_groups =  [aws_security_group.frontend_sg.id]

  tags = {
    Name = "spacex-frontend-lb"
  }
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "spacex-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.frontend_vpc.id

  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}
