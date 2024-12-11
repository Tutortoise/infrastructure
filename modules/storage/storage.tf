resource "google_storage_bucket" "bucket" {
  name          = "tutortoise-bucket"
  location      = var.location
  force_destroy = false
}

resource "google_storage_bucket" "model" {
  name          = "tutortoise-model"
  location      = var.location
  force_destroy = false
}

resource "google_storage_bucket_iam_member" "all_users" {
  for_each = toset([
    google_storage_bucket.bucket.name,
    google_storage_bucket.model.name
  ])

  bucket = each.value
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}