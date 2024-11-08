variable "hcp_packer_registry_enabled" {
  type        = bool
  description = "Set to true to submit metadata to HCP."
  default     = false
}

variable "bucket_name" {
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

