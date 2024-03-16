output "public_ip" {
  value = aws_instance.server2.public_ip
  
}
  

output "utc_private_key" {
  value       = tls_private_key.utc-key.private_key_pem
  sensitive = true

}

output "utc_public_key" {
  value       = tls_private_key.utc-key.public_key_openssh
}
output "ssh-command" {
  value = "ssh -i utc-key.pem ec2-user@${aws_instance.server2.public_ip}"
}