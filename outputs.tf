# output "public_ip" {
#   value       = aws_instance.example.public_ip
#   description = "The public IP address of the web server"
# }

output "vpc-id" {
  value       = data.aws_subnets.default.ids
  description = "VPC ID's"
}


output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}