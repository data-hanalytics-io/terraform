# [START compute_hanalytics_quickstart_vm]


# [START compute_regional_external_vm_address]
resource "google_compute_address" "default" {
  name   = "static-ip-address"
  region = var.region
}
# [END compute_regional_external_vm_address]

# Create a single Compute Engine instance
resource "google_compute_instance" "vm_instance" {
  name         = "hanalytics-instance"
  machine_type = "e2-micro"
  zone = var.zone
  tags         = ["ssh", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = file("startup.sh")

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.default.address
    }
  }
}
# [END compute_hanalytics_quickstart_vm]

resource "google_compute_network" "vpc_network" {
  name                    = "hanalytics-network"
  auto_create_subnetworks = "true"
}

# [START vpc_hanalytics_quickstart_ssh_fw]
resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
# [END vpc_hanalytics_quickstart_ssh_fw]
 
# [START vpc_hanalytics_quickstart_ports_fw]
resource "google_compute_firewall" "app-firewall" {
  name    = "hanalytics-app-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["5000","8080","8000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
# [END vpc_hanalytics_quickstart_ports_fw]