resource "google_compute_firewall" "allow_all_internal" {
  name    = "allow-all-internal"
  network = google_compute_network.cicd_network.name

  # Permite todo o tráfego interno entre instâncias
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}
