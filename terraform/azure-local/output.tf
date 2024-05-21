output "bucket_name" {
  value = data.hcp_packer_artifact.this.bucket_name
}

output "platform" {
  value = data.hcp_packer_artifact.this.platform
}

output "created_at" {
  value = data.hcp_packer_artifact.this.created_at
}
