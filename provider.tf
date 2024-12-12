provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-c"
}

terraform {
  backend "gcs" {
    bucket = "tutortoise-terraform"
    prefix = ".terraform/state"
  }
}