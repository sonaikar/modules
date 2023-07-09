output "subnet_id" {
  value = aws_subnet.intuitive-subnet.id
}

output "ssh_security_group_id" {
  value = aws_security_group.ssh-security-group.id
}

output "vpc_id" {
  value = aws_vpc.intuitive-vpc.id
}
