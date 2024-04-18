variable "azure_subscription_id" {
  type        = string
  description = "The subscription id of the service principal, store in GitHub secrets"
  default     = ""
}

variable "azure_tenant_id" {
  type        = string
  description = "The tenant id of the service principal, store in GitHub secrets"
  default     = ""
}

variable "azure_client_id" {
  type        = string
  description = "The client id of the service principal, store in GitHub secrets"
  default     = ""
}

variable "azure_client_secret" {
  type        = string
  description = "The client secret of the service principal, store in GitHub secrets"
  default     = ""
}