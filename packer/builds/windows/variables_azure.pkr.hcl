variable "azure_subscription_id" {
  type        = string
  description = "The subscription id of the service principal, store in GitHub secrets"
  default     = "16f1299e-c5d6-4d0a-8c74-35852359c75b"
}

variable "azure_tenant_id" {
  type        = string
  description = "The tenant id of the service principal, store in GitHub secrets"
  default     = "ab2e4aa2-3855-48b9-8d02-619cee6d9513"
}

variable "azure_client_id" {
  type        = string
  description = "The client id of the service principl, store in GitHub secrets"
  default    = "6b4310c7-6b0e-4c4d-be2a-22c588eeb3b3"
}

variable "azure_client_secret" {
  type        = string
  description = "The client secret of the service principal, store in GitHub secrets"
  default     = "DiW8Q~Vlz7YCNCJ.LX13~sHDupCcHhRht.psKdlr"
}