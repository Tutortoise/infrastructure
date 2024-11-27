resource "google_storage_bucket" "bucket" {
  name          = "tutortoise-bucket"
  location      = var.location
  force_destroy = true
}

resource "google_storage_bucket_acl" "bucket_acl" {
  bucket = google_storage_bucket.bucket.name
  role_entity = [
    "READER:allUsers",
  ]
}
