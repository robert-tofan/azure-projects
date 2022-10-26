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

variable "mysql-name" {

  type        = string
  default     = "robert-mysql"

}

variable "mysql-server-user" {
  type      = string
  sensitive = true
}

variable "mysql-server-pass" {
  type      = string
  sensitive = true
}