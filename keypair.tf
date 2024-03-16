resource "tls_private_key" "utc-key" {
  algorithm   = "RSA"
  rsa_bits    = 2048
}
resource "aws_key_pair" "utc-key" {
  key_name   = "utc-key"
  public_key = tls_private_key.utc-key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "utc-key.pem"
  content  = tls_private_key.utc-key.private_key_pem
}