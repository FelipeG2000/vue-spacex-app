
resource "aws_security_group" "frontend_sg" {
  name        = "spacex-frontend-sg"
  description = "Allow HTTP traffic to the ECS tasks"
  vpc_id      = aws_vpc.frontend_vpc.id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "spacex-frontend-sg"
  }
}

