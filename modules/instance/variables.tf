variable "network" {
  description = "network to deploy the instance"
}

variable "subnet" {
  description = "subnet to deploy the instance"
}

variable "service_account" {
  description = "service account to assign to the instance"
}

variable "static_ip" {
  description = "static ip to assign to the instance"
  default     = null
}