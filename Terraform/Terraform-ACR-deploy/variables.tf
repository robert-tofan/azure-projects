variable "prefix" {
  type    = string
  default = "robert"
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "sku tier"

}
variable "acr-name" {
  type        = string
  default     = "robert-acr"
  description = "sku tier"

}

variable "resource_group_name" {
  type        = string
  default     = "robert260398"
  description = "sku tier"

}

variable "location" {
  type        = string
  default     = "East US"
  description = "region"

}

variable "smekerie" {

  type = bool

  default = true

}