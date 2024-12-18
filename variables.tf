variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region to deploy the resources"
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
