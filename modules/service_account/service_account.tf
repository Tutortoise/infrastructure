resource "google_service_account" "sa" {
  account_id   = var.account_id
  display_name = var.account_id
}

resource "google_project_iam_member" "sa_roles" {
  for_each = var.roles

  project = var.project_id
  member  = "serviceAccount:${google_service_account.sa.email}"
  role    = each.value
}