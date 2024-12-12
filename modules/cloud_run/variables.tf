variable "project_id" {
  description = "project id"
}

variable "location" {
  description = "location to deploy the resources"
}

variable "service_account" {
  description = "service account email"
}

variable "ENV_DATABASE_URL" {
  description = "env"
  sensitive   = true
}

variable "ENV_JWT_SECRET" {
  description = "env"
  sensitive   = true
}

variable "ENV_FIREBASE_DATABASE_URL" {
  description = "env"
  sensitive   = true
}
