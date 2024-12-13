resource "google_cloud_run_service" "backend" {
  name     = "tutortoise-backend"
  location = var.location

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "3"
        "autoscaling.knative.dev/minScale" = "1"
        "run.googleapis.com/client-name"   = "cloud-console"
        "run.googleapis.com/container-dependencies" = jsonencode(
          {
            tutortoise-backend-1 = [
              "face-validation-service-1",
              "bilingual-abusive-detection-service-1",
            ]
          }
        )
        "run.googleapis.com/execution-environment" = "gen2"
        "run.googleapis.com/network-interfaces" = jsonencode(
          [
            {
              network    = "vpc-network"
              subnetwork = "vpc-subnet"
            },
          ]
        )
        "run.googleapis.com/sessionAffinity"   = "true"
        "run.googleapis.com/startup-cpu-boost" = "true"
        "run.googleapis.com/vpc-access-egress" = "private-ranges-only"
      }

      labels = {
        "client.knative.dev/nonce"            = "a1e68fac-aed9-4bfb-a845-6bb192d27ae9"
        "commit-sha"                          = "85f56b463fa71357580b96d8b9e52dcb1aa5d773"
        "gcb-build-id"                        = "d3431a6b-3ff2-494e-bf16-90afdd54d305"
        "gcb-trigger-id"                      = "f529fdff-9444-48ed-b06b-5ecc13d39cb5"
        "gcb-trigger-region"                  = "global"
        "managed-by"                          = "gcp-cloud-build-deploy-cloud-run"
        "run.googleapis.com/startupProbeType" = "Custom"
      }
    }

    spec {
      service_account_name  = var.service_account
      container_concurrency = 80
      timeout_seconds       = 300

      containers {
        image = "asia-southeast2-docker.pkg.dev/${var.project_id}/tutortoise/backend:latest"
        name  = "tutortoise-backend-1"

        env {
          name  = "ABUSIVE_DETECTION_URL"
          value = "http://localhost:8000"
        }
        env {
          name  = "FACE_VALIDATION_URL"
          value = "http://localhost:9090"
        }
        env {
          name  = "FIREBASE_DATABASE_URL"
          value = var.ENV_FIREBASE_DATABASE_URL
        }
        env {
          name  = "DATABASE_URL"
          value = var.ENV_DATABASE_URL
        }
        env {
          name  = "JWT_SECRET"
          value = var.ENV_JWT_SECRET
        }
        env {
          name  = "FIREBASE_SERVICE_ACCOUNT_KEY"
          value = file("./firebase-service-account-key.json")
        }
        env {
          name  = "GCS_BUCKET_NAME"
          value = "tutortoise-bucket"
        }
        env {
          name  = "SYSTEM_RECOMMENDER_URL"
          value = "http://10.10.10.3:8000"
        }

        ports {
          container_port = 8080
          name           = "http1"
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "1Gi"
          }
        }

        startup_probe {
          failure_threshold     = 1
          initial_delay_seconds = 5
          period_seconds        = 240
          timeout_seconds       = 240

          tcp_socket {
            port = 8080
          }
        }
      }
      containers {
        image = "asia-southeast2-docker.pkg.dev/${var.project_id}/tutortoise/face-validation-service:latest"
        name  = "face-validation-service-1"

        env {
          name  = "PORT"
          value = "9090"
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "1Gi"
          }
        }

        startup_probe {
          failure_threshold     = 3
          initial_delay_seconds = 5
          period_seconds        = 10
          timeout_seconds       = 1

          http_get {
            path = "/health"
            port = 9090
          }
        }
      }
      containers {
        image = "asia-southeast2-docker.pkg.dev/${var.project_id}/tutortoise/bilingual-abusive-detection-service:latest"
        name  = "bilingual-abusive-detection-service-1"

        env {
          name  = "GRANIAN_MAX_WORKERS"
          value = "2"
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "1Gi"
          }
        }

        startup_probe {
          failure_threshold     = 3
          initial_delay_seconds = 5
          period_seconds        = 10
          timeout_seconds       = 1

          http_get {
            path = "/health"
            port = 8000
          }
        }
      }
    }
  }

  traffic {
    latest_revision = true
    percent         = 100
  }
}
