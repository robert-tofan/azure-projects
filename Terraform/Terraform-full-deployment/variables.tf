
// AKS varibles

variable "if-aks" {

  type        = bool
  default     = true
  description = "if true aks will be created"

}

variable "aks-name" {

  type    = string
  default = "robert-kube"

}

variable "aks-dns-prefix" {

  type    = string
  default = "aks-robert-prefix"

}

variable "aks-node-count" {

  type    = number
  default = 1

}

variable "aks-vm-size" {

  type    = string
  default = "Standard_B2s"

}



// mysql server variables

variable "if-mysql" {

  type        = bool
  default     = false
  description = "if true mysql will be created"

}

variable "mysql-name" {

  type        = string
  default     = "robert-mysql"
  description = "if true mysql will be created"

}

variable "mysql-server-user" {
  type      = string
  sensitive = true
}

variable "mysql-server-pass" {
  type      = string
  sensitive = true
}

// mysql db varibles

variable "if-mysql-db" {

  type        = bool
  default     = false
  description = "if true mysql database will be created"

}

variable "firewall-ip" {
  type      = string
  default   = "86.120.48.159"
  sensitive = true
}

// firewall varibles 

variable "if-firewall" {

  type        = bool
  default     = false
  description = "if true firewall will be created"

}

//ACR varibles

variable "if-acr" {

  type        = bool
  default     = true
  description = "if true acr will be created"

}

variable "acr-name" {
  type    = string
  default = "robert260398"
}

variable "acr-sku" {
  type    = string
  default = "Basic"
}

// public ip varibles

variable "if-public-ip" {

  type        = bool
  default     = true
  description = "if true public ip will be created"

}

// DNS zone variables


variable "if-dns-zone" {

  type        = bool
  default     = true
  description = "if true dns zone will be created"

}

// DNS a recorder variables 

variable "if-dns-a-record" {

  type        = bool
  default     = true
  description = "if true dns a recorder will be created"

}

variable "default_tags" {
  type    = string
  default = "anvironment = learn"

}

// Variables for manifests

variable "if-manifest" {

  type        = bool
  default     = true
  description = "if true dns a recorder will be created"

}