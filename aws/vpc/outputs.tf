output "public_elastic_ip" {
  value = aws_eip.eip.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "public_security_group_id" {
  value = aws_security_group.public_sg.id
}
