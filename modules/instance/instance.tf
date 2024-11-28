resource "google_compute_instance" "db_instance" {
  name         = "database"
  zone         = var.zone
  machine_type = "e2-custom-2-4096"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      # type  = "pd-ssd"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet
    access_config {
    }
  }

  metadata = {
    startup-script = file("./startup-script/setup.sh")
  }

  allow_stopping_for_update = true
}