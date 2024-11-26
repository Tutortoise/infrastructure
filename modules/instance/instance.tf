resource "google_compute_instance" "db_instance" {
  name         = "database"
  zone         = var.zone
  machine_type = "e2-micro"

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

  # metadata = {
  #   startup-script = file("./startup-script/setup_db.sh")
  # }
}