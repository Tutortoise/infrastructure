variable "location" {
  description = "The location of the Cloud Build trigger"
  default     = "asia-east1"
  # why we use asia-east1 instead of asia-southeast2?
  # read this: https://cloud.google.com/build/docs/locations#restricted_regions_for_some_projects
}

variable "service_account_id" {
  description = "The service account to use for the Cloud Build trigger"
}