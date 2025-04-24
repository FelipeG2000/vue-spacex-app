
output "load_balancer_dns" {
  description = "Public DNS of the frontend ALB"
  value       = aws_lb.frontend_lb.dns_name
}

output "ecr_repo_url" {
  description = "URL of the frontend ECR repository"
  value       = aws_ecr_repository.frontend_repo.repository_url
}