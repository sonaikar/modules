output "ec2_instance" {
  value = aws_instance.intuitive_instance.*.id
}