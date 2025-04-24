output "ecs_cluster_name" {
  description = "ECS Cluster name"
  value       = aws_ecs_cluster.frontend_cluster.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.frontend_task.arn
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "load_balancer_dns" {
  description = "Public DNS of the frontend ALB"
  value       = aws_lb.frontend_lb.dns_name
}

output "ecr_repo_url" {
  description = "URL of the frontend ECR repository"
  value       = aws_ecr_repository.frontend_repo.repository_url
}