output "network_link" {
  value = google_compute_network.vpc_network.self_link
}

output "subnet_link" {
  value = google_compute_subnetwork.vpc_subnet.self_link
}

output "static_ip_address" {
  value = google_compute_address.static_ip.address
}