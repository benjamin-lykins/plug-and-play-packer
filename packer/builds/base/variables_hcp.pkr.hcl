# 

## Following variables are when building the image and pushing to the HCP Packer Registry. 
variable "hcp_packer_registry_push" {
  type        = bool
  description = "Set to true to push the metadata to the registry."
  default     = false
}

variable "hcp_packer_bucket_name_push" {
  type        = string
  description = "The name of the bucket to store the metadata."
  default     = ""
}

variable "bucket_description" {
  type        = string
  description = "The name of the bucket to store the metadata."
  default     = ""
}

variable "bucket_labels" {
  type        = map(string)
  description = "Labels to apply to the bucket."
  default     = {}
}

variable "build_labels" {
  type        = map(string)
  description = "Labels to apply to the bucket."
  default     = {}
}