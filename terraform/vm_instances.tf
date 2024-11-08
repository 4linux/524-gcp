resource "google_compute_instance" "vm_instances" {
  count        = 4
  name         = ["cicd", "cicd-tools", "k3s", "gitlab-ci"][count.index]
  machine_type = var.machine_type # Substitua pelo tipo de máquina desejado
  zone = var.default_zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-11" # Imagem Debian
    }
  }

  # Conecta a VM na sub-rede criada
  network_interface {
    network    = google_compute_network.cicd_network.name
    subnetwork = google_compute_subnetwork.cicd_subnet.name
    access_config {
      nat_ip = google_compute_address.static_ip[count.index].address
    }
  }
  metadata = {
    ssh-keys = "araujo_emerson28:${file("id_rsa_gcp.pub")}"
  }

}

resource "google_compute_address" "static_ip" {
  count = 4
  name  = ["cicd-ip", "cicd-tools-ip", "k3s-ip", "gitlab-ci-ip"][count.index]
  region = var.default_region # Substitua pela região padrão desejada
}
