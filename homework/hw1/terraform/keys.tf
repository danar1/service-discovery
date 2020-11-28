resource "tls_private_key" "service_discovery_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "service_discovery_key" {
  key_name   = "service_discovery_key"
  public_key = tls_private_key.service_discovery_key.public_key_openssh
}

resource "local_file" "service_discovery_key" {
  sensitive_content  = tls_private_key.service_discovery_key.private_key_pem
  file_permission    = "0600"
  filename           = "service_discovery_key.pem"
}