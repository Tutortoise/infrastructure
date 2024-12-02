resource "google_storage_bucket" "bucket" {
  name          = "tutortoise-bucket"
  location      = var.location
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "all_users" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}