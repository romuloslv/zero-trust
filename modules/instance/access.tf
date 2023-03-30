resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_file" "generate_ssh" {
  filename        = "sysout/key/private_key.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0600"
}