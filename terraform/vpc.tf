resource "google_compute_network" "cicd_network" {
  name = "cicd-network"
}

# Configuração da Sub-rede
resource "google_compute_subnetwork" "cicd_subnet" {
  name          = "cicd-subnet"
  ip_cidr_range = "198.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.cicd_network.name
}