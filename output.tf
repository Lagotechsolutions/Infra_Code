output "public_ip_address" {
    description = "IP address will be used to access the Jenkins Server"
    value = aws_instance.example.public_ip
}   