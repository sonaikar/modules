locals {
  #loclal vars here
  local-tag = {
    cot-tag = "1.0"
  }
  org-name  = "my-org"
  dept-name = "my-dept"
  common-tags = {
    prefix = "${local.org-name}-${local.dept-name}"
  }
}

data "aws_ami" "ec2-image" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

data "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCfvjpWm2ftg3tnOEcm+6W9fIG1JYZbxRSa0vwMWg73qKjR61d548nzaMtwJiuM2Qhs/4fOM9onoY/ZInaqL1shclEma9adi3EGlP/IHY41Wow/qTR+UET58Xbva8saYddJKB8pJZsGOkjj6itZmabZasmsRwuP16fKXAnln18bh2V54gRiwBND9xakjFcQ9T0/aczWqBmXra/2HXXK+d8hBC3ja26KyfkFIEjR1UZP4ftOY2FXiH2E7uOAGaKTPfneFDUG+Rd/n5T/KqhhazswFUnN/2rHVYBiReyW6Dmzkpdk642dNLQxoGTYaVKmI4Y13JKWB9ZfRCexJozx20FAJnc7+7Zw+jKodBubW91bsTzHGk/EwFofZyPC2tyFJnZWbChkmzce/5tgEI54zxb+tQ3AfAxnTL20HW7ZOh6+IhwXsYhSZYdqKLBQEaqEAO+hj/o4ugAMettLYwWHnIf+qbSsa2mGDJVpkyxN3W9OJN/OIDkcxnJcM6yZsUVcG6k= tarakant@US-3V33XD3"
}

resource "aws_instance" "intuitive_instance" {
  count = var.vm-count

  ami             = data.aws_ami.ec2-image.id
  key_name        = data.aws_key_pair.deployer.key_name
  security_groups = [var.security_group_id]
  subnet_id       = var.subnet_id
  instance_type   = var.instance_type

  associate_public_ip_address = true

  tags = merge(local.local-tag, local.common-tags)
}

resource "aws_volume_attachment" "ebs" {
  count = var.vm-count

  device_name = "/dev/sdh"
  volume_id   = var.ebs_volume_id[count.index]
  instance_id = aws_instance.intuitive_instance[count.index].id
}
