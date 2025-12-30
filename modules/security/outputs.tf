output "nginx_sg_id" {
  description = "Security group ID for Nginx"
  value       = aws_security_group.nginx_sg.id
}

output "backend_sg_id" {
  description = "Security group ID for backend servers"
  value       = aws_security_group.backend_sg.id
}
