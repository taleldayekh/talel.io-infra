output "public_security_group_id" {
    value = aws_security_group.public_sg.id
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}
