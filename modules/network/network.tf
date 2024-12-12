resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "vpc-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.10.10.0/24"
}

resource "google_compute_firewall" "firewalls" {
  for_each = tomap({
    "allow-ssh" = {
      public         = true
      allow_protocol = "tcp"
      allow_ports    = ["22"]
    },
    "allow-postgres" = {
      public         = false
      allow_protocol = "tcp"
      allow_ports    = ["5432"]
    },
    "allow-8000" = {
      public         = false
      allow_protocol = "tcp"
      allow_ports    = ["8000"]
    },
  })

  name          = each.key
  network       = google_compute_network.vpc_network.self_link
  target_tags   = [each.key]
  source_ranges = !each.value.public ? [google_compute_subnetwork.vpc_subnet.ip_cidr_range] : ["0.0.0.0/0"]

  allow {
    protocol = each.value.allow_protocol
    ports    = each.value.allow_ports
  }
}

resource "google_compute_address" "static_ip" {
  name         = "static-ip"
  address_type = "EXTERNAL"
}