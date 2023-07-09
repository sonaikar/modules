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

data "aws_ec2_instance_type_offerings" "ec2-image" {
  most_recent = true

  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }
  filter {
    name   = "location"
    values = ["us-west-2"]
  }
  filter {
    name   = "name"
    values = "*Ubuntu.22.04.*"
  }
  location_type = "us-west-2a"
}

resource "aws_instance" "intuitive_instance" {
  count = var.vm-count

  ami             = data.aws_ec2_instance_type_offerings.ec2-image.id
  key_name        = var.ssh_key_name
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
