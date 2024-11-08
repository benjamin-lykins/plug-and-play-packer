variable "hcp_packer_registry_enabled" {
  type        = bool
  description = "Set to true to submit metadata to HCP."
  default     = false
}

variable "bucket" {
  type        = string
  description = "The name of the bucket to store the metadata."
  default     = ""
}
