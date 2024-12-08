variable "project_id" {
  description = "The project ID"
}

variable "account_id" {
  description = "The account ID"
}

variable "roles" {
  description = "The roles to assign to the service account"
  type        = set(string)
}
