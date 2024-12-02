resource "google_project_iam_member" "db-instance-sa" {
  for_each = toset([
    "storage.objectCreator",
    "storage.objectViewer",
  ])

  member  = "serviceAccount:${module.db-instance-sa.email}"
  project = var.project_id
  role    = "roles/${each.key}"
}