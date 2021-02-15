output "security_groups" {
  value = aws_instance.web.*.security_groups
}

output "public_dns" {
  value = aws_instance.web.*.public_dns
}

output "public_ip" {
  value = aws_instance.web.*.public_ip
}

output "private_key_filename" {
  value = tls_private_key.ubuntu_key
}