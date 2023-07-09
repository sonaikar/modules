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

resource "aws_ebs_volume" "intuitive_ebs_volumes" {
  count = var.ebs_volumes

  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type

  tags = merge(local.local-tag, local.common-tags)
}
