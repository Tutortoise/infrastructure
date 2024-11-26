provider "google" {
  project = "bangkit-c242-ps567"
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket = "tutortoise-terraform"
    prefix = ".terraform/state"
  }
}