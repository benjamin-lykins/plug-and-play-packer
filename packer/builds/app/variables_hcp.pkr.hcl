# Authenticated with HCP
## Following environment variables need to be set
## export HCP_CLIENT_ID=
## export HCP_CLIENT_SECRET=
## export HCP_PROJECT_ID=
## Optional, if a build was incompleted, you can set export HCP_PACKER_BUILD_FINGERPRINT= 
## Full documentation
## https://developer.hashicorp.com/packer/docs/hcp

## Following variables are when building the image and pushing to the HCP Packer Registry. 
variable "hcp_packer_registry_push" {
  type        = bool
  description = "Set to true to push the metadata to the registry."
  default     = false
}

variable "hcp_packer_bucket_name_push" {
  type        = string
  description = "The name of the bucket to store the metadata. Only necessary if hcp_packer_registry_push is true."
  default     = ""
}

variable "bucket_description" {
  type        = string
  description = "The name of the bucket to store the metadata. Only necessary if hcp_packer_registry_push is true."
  default     = ""
}

variable "bucket_labels" {
  type        = map(string)
  description = "Labels to apply to the bucket. Only necessary if hcp_packer_registry_push is true."
  default     = {}
}

variable "build_labels" {
  type        = map(string)
  description = "Labels to apply to the bucket. Only necessary if hcp_packer_registry_push is true."
  default     = {}
}

## Following variables are when sourcing the metadata and injecting into source blocks. 

variable "hcp_packer_registry_pull" {
  type        = bool
  description = "Set to true to pull the metadata from the registry."
  default     = false
}

variable "hcp_packer_bucket_name_pull" {
  type        = string
  description = "The name of the bucket to retrieving metadata. Only necessary if hcp_packer_registry_pull is true."
  default     = ""
}

variable "hcp_packer_channel_name_pull" {
  type        = string
  description = "The name of the channel to retrieve metadata. Only necessary if hcp_packer_registry_pull is true."
  default     = ""
}

