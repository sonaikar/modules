output "ebs_volume_id" {
  description = "The volume ID"
  value = split(",",join(",",aws_ebs_volume.intuitive_ebs_volumes.*.id))


}

output "ebs_volume_arn" {
  description = "The volume ARN"
  value = split(",",join(",",aws_ebs_volume.intuitive_ebs_volumes.*.arn))
}
