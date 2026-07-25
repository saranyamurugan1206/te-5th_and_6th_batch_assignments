output "vpc_id" {
  description = "id of vpc"
  value       = aws_vpc.main.id
}

output "web_public_ip" {
  description = "public ip of ec2 instance"
  value       = aws_eip.web_server.public_ip
}

output "web_public_url" {
  description = "web server public url"
  value       = "http://${aws_eip.web_server.public_ip}"
}

output "db_private_ip" {
  description = "private ip of ec2 instance"
  value       = aws_instance.db_server.private_ip
}