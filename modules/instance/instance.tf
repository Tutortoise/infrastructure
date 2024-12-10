resource "google_compute_instance" "db_instance" {
  name         = "database"
  machine_type = "e2-medium"
  tags         = ["allow-ssh", "allow-postgres", "allow-8000"]

  service_account {
    email  = var.service_account != null ? var.service_account : null
    scopes = ["cloud-platform"]
  }

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
      nat_ip = var.static_ip
    }
  }

  metadata = {
    startup-script = file("./startup-script/setup.sh")
  }

  allow_stopping_for_update = true
}