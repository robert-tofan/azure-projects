// Resource group variable

variable "resource-group-name" {

  type    = string

}


// AKS varibles

variable "if-aks" {

  type        = bool
  default     = true
  description = "if true aks will be created"

}

variable "aks-name" {

  type    = string

}

variable "aks-dns-prefix" {

  type    = string

}

variable "aks-node-count" {

  type    = number

}

variable "aks-vm-size" {

  type    = string

}

variable "nodepool-name" {

  type    = string

}


//ACR varibles

variable "if-acr" {

  type        = bool
  default     = true
  description = "if true acr will be created"

}

variable "acr-name" {
  type    = string
}

variable "acr-sku" {
  type    = string
}

// Helm ingress controller variables

variable "nginx-name" {
  type    = string

}

variable "nginx-namespace" {
  type    = string

}

// Helm cert manager variables


variable "cert-manager-name" {
  type    = string

}

variable "cert-manager-namespace" {
  type    = string

}
