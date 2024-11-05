variable "azure_subscription_id" {
  type        = string
  description = "The subscription id of the service principal, store in GitHub secrets"
  default     = "16d750eb-6d45-404c-a06a-a507a663be9e"
}

variable "azure_tenant_id" {
  type        = string
  description = "The tenant id of the service principal, store in GitHub secrets"
  default     = "ab2e4aa2-3855-48b9-8d02-619cee6d9513"
}

variable "azure_client_id" {
  type        = string
  description = "The client id of the service principal, store in GitHub secrets"
  default     = "0f8f403e-de04-422b-abab-09a30560e609"
}

variable "azure_client_secret" {
  type        = string
  description = "The client secret of the service principal, store in GitHub secrets"
  default     = "JQg8Q~gJYKlL1jfRI1hODhQrzX2YrdDI1kcx1diW"
}
