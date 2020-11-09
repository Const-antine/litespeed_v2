resource "google_compute_network" "default" {
  name                    = "infra-network"
  auto_create_subnetworks = true
  routing_mode            = "REGIONAL"
  project                 = var.project

}

resource "google_compute_firewall" "default" {
  name          = "infra-firewall"
  network       = google_compute_network.default.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.open_ports
  }
}
