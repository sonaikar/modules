locals {
  org-name  = "my-org"
  dept-name = "my-dept"
  common-tags = {
    prefix = "${local.org-name}-${local.dept-name}"
  }
}

resource "aws_s3_bucket" "intuitive-s3" {
  bucket = var.bucket_name
  acl    = var.acl_value

  tags = local.common-tags
}