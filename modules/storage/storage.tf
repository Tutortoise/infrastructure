resource "google_storage_bucket" "gcs" {
  name          = "tutortoise-bucket"
  location      = var.location
  force_destroy = true
}
