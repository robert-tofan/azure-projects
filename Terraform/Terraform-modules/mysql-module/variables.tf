// Resource group variable

variable "resource-group-name" {

  type    = string

}

// mysql server variables

variable "mysql-name" {

  type        = string
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


variable "firewall-start-ip" {
  type      = string
  sensitive = true
}

variable "firewall-end-ip" {
  type      = string
  sensitive = true
}

variable "name-database" {
  type      = string
}

variable "firewall-name" {
  type      = string
}