variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["value_for_variables"]
}

variable "rgname" {
  type        = string
  description = "resource group name"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "clustername" {
  type = string
}

variable "appId" {
  type = string
}

variable "password" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "public_lb" {
  type = string
}

# variable "client_certificate" {
#   type = string
# }

# variable "client_key" {
#   type = string
# }

# variable "cluster_ca_certificate" {}