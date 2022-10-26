variable "resource_group_name" {
  type        = string
  default     = "robert-projects"
  description = "Resource Group name"
}
variable "location" {
  type        = string
  default     = "West Europe"
  description = "Region"
}
variable "aks_name" {
  type        = string
  default     = "robert-kube"
  description = "AKs name"
}
variable "node_number" {
  type        = number
  default     = 1
  description = "aks nodes number"
}