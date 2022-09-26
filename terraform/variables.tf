variable "env" {
  description = "Environment"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "West Europe"
}

variable "app_name" {
  default = "multicontainerwordpress"
}

