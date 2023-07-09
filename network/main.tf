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

resource "aws_vpc" "intuitive-vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(local.local-tag, local.common-tags)
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.intuitive-vpc.id
  tags   = merge(local.local-tag, local.common-tags)
}

resource "aws_subnet" "intuitive-subnet" {

  vpc_id                  = aws_vpc.intuitive-vpc.id
  cidr_block              = var.cidr
  availability_zone       = var.region
  map_public_ip_on_launch = true

  tags = merge(local.local-tag, local.common-tags)
}


resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.intuitive-vpc.id
  route {
    cidr_block = var.cidr
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = merge(local.local-tag, local.common-tags)
}

resource "aws_route_table_association" "public-subnet-route-table-association" {

  subnet_id      = aws_subnet.intuitive-subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "ssh-security-group" {
  name        = "intuitive ssh security group"
  description = "Enable ssh access to port 22"

  vpc_id = aws_vpc.intuitive-vpc.id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.ssh-location]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.local-tag, local.common-tags)
}
