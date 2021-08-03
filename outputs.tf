output "ecs_ami_id" {
  description = "ECS Optimized AMI ID"
  value       = data.aws_ami.amazon_linux_ecs.id
}

output "ecs_security_group_id" {
  description = "Security Group ID attached to ECS nodes"
  value       = aws_security_group.ecs.id
}