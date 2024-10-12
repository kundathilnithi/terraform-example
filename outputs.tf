# output "public_ip" {
#   value       = aws_instance.example.public_ip
#   description = "The public IP address of the web server"
# }

output "vpc-id" {
  value       = data.aws_subnets.default.ids
  description = "VPC ID's"
}