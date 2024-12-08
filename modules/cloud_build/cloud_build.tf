resource "google_cloudbuild_trigger" "backend_build" {
  name               = "backend-build"
  description        = "Build and deploy to Cloud Run service tutortoise-backend on push to \"^master$\""
  location           = var.location
  service_account    = var.service_account_id
  filename           = "cloudbuild.yaml"
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"

  tags = [
    "gcp-cloud-build-deploy-cloud-run",
    "gcp-cloud-build-deploy-cloud-run-managed",
    "tutortoise-backend",
  ]

  approval_config {
    approval_required = false
  }

  github {
    name  = "backend"
    owner = "Tutortoise"
    push {
      branch = "^master$"
    }
  }
}

resource "google_cloudbuild_trigger" "face_validation_service_build" {
  name            = "face-validation-service-build"
  description     = "Trigger to build Docker image for Tutortoise's face validation service"
  location        = var.location
  service_account = var.service_account_id
  filename        = "cloudbuild.yaml"

  approval_config {
    approval_required = false
  }

  github {
    name  = "face-validation-service"
    owner = "Tutortoise"
    push {
      branch = "^master$"
    }
  }
}


resource "google_cloudbuild_trigger" "bilingual_abusive_detection_service_build" {
  name            = "bilingual-abusive-detection-service-build"
  description     = "Trigger to build Docker image for Tutortoise's bilingual abusive detection service"
  location        = var.location
  service_account = var.service_account_id
  filename        = "cloudbuild.yaml"

  approval_config {
    approval_required = false
  }

  github {
    name  = "bilingual-abusive-detection-service"
    owner = "Tutortoise"
    push {
      branch = "^main$"
    }
  }
}